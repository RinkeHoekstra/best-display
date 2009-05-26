<?php
  require_once("/home/huygen/BEST/devroot/lib/vu.cli.best.ontologyconnect.php");
  class Concepto {
    var $uri;              // ID of the concept.
    var $title;            // title of the concept.
    var $explanation;      // text with explanation.
    var $superconcepts;    // array of super-classes.
    var $fingerphrases;    // array of fingerprint phrases.
    var $fingerweights;    // array of fingerprint weights.
    var $relevantverdicts=array(); // array of relevant verdicts.
    var $fingercount;
    var $matchstring = "";
    var $matchcount = 0;
    var $matchoff;
    var $matchlen;
    var $matchfingnum;
    var $singlewordmatchcount = 0;
    var $multiwordmatchcount = 0;
    var $matchweightssum = 0;
    
    function uri(){
     return $this->uri;
    }
    
    function title(){
     return $this->title;
    }
    
    function explanation(){
     return $this->explanation;
    }
    
    function verdicts(){
     return $this->relevantverdicts;
    }
    
    function fingerphrases(){
      return $this->fingerphrases;
    }
    
    function fingerweights(){
      return $this->fingerweights;
    }
    
    function __construct($uri){
      $this->uri=$uri;
      if(preg_match("/^fp/", $uri)<=0){
        if(stripos($uri, "#")===FALSE) $uri="<http://www.owl-ontologies.com/OnrechtmatigeDaad.owl#".$uri.">";
        
        $this->uri=$uri;
        $this->read_ontology($uri);
        $this->read_phrases();
        $this->get_LJNs_from_Collexis();
      } else {
        $this->uri=$uri;
        $conceptnum=0+preg_replace("/^fp/", "", $uri);
        $this->init_with_fingerprint_file($uri);
        $this->get_helptext_from_helpfile($conceptnum);
        $this->get_LJNs_from_list($conceptnum);
      }
      
    }
    
    function read_ontology($uri){
      $ontc=new Ontologyconnect();
      list($this->title)=$ontc->get_object_elements( $uri
                                                     , $ontc->best_preflabel
                                                     , "literal"
                                                     );
      
      list($this->explanation)=$ontc->get_object_elements( $uri
                                                           , $ontc->rdfs_comment
                                                           , "literal"
                                                           );
      
      $subject=$uri;
      $predicaat1=$ontc->rdfs_subclass;
      $predicaat2=$ontc->best_preflabel;
      $query="select ?x where { ".$subject." ".$predicaat1." ?x ";
      $query=$query." . ?x $predicaat2 [] . }";
      $response=$ontc->selectquery($query);
      if($response===FALSE){
        $this->superconcepts=FALSE;
      } else {
        $xml=new SimpleXMLElement($response);
        $ar=$xml->results[0]->result[0]->binding[0]->uri;
        for($i=0;$i<count($ar);$i++){
          $this->superconcepts[$i]=new Concepto("<".$ar[$i].">");
        };
      };
      
    }
    
    function read_phrases(){
      $pat[0]="/ /"; $repl[0]="_";
      $pat[1]="/:/"; $repl[1]="_";
      $sfpath="/home/huygen/BEST/concepts/".strtolower(preg_replace($pat, $repl, $this->title));
      
      if(is_file($sfpath)){
        $handle=fopen($sfpath, "rb");
        $linenum=0;
        unset($this->fingerphrases);
        unset($this->fingerweights);
        while(!feof($handle)){
          $line=trim(fgets($handle));
          $ar=explode("\t", $line);
          $weight=trim(reset($ar));
          $phrase=trim(next($ar));
          if(strlen($phrase)>1){
            $linenum++;
            $this->fingerweights[$linenum]=$weight;
            $this->fingerphrases[$linenum]=$phrase;
          };
        };
        fclose($handle);
      } else {
        $this->fingerphrases=FALSE;
      };
      
      
    }
    function init_with_fingerprint_file($fpnam){
      if ($handle = fopen("/home/huygen/BEST/concepts/".$fpnam, "rb")) {
        $this->title=rtrim(fgets($handle));
        $this->fingercount=0;
        while(!feof($handle)){
         $infracs=explode("\t", rtrim(fgets($handle)));
         if($infracs[1]!=""){
           $this->fingercount++;
           $this->fingerweights[$this->fingercount]=$infracs[0];
           $this->fingerphrases[$this->fingercount]=$infracs[1];
         };
        };  
        
        fclose($handle);
      } else {
        printf("Message: %s\n", "Kan fingerprints niet lezen");
        
        $rets="Concept ".$conceptnum." isternie";
      };
    
    }
    function get_helptext_from_helpfile($conceptnum){
      $concepthelpfil="/home/CLI/www/best/display/help/concepthelp";
      $this->explanation="";
      if($handle=fopen($concepthelpfil,  "rb")){
        while(!feof($handle)){
          $linarr = explode("\t", rtrim(fgets($handle)));
          if($linarr[0]==$conceptnum){
            $this->explanation=$linarr[1];
            break;
          };
        };
      };
    }
    
    function get_LJNs_from_list($conceptnum){
      $filnam="/home/huygen/BEST/display/resources/verdictslist.fp".$conceptnum;
      if(file_exists($filnam)){
        $this->relevantverdicts=file($filnam, FILE_IGNORE_NEW_LINES);
      };
    }
    
    function get_LJNs_from_Collexis(){
      $this->relevantverdicts=get_related_document_refs( $this->seeddoc()
                                                        , $this->collID()
                                                        );
      $cnt=count($this->relevantverdicts);
      if($cnt<=0) return 0;
      $cnt=0;
      $ljnpattern="/^[A-Z][A-Z][0-9][0-9][0-9][0-9]/";
      foreach($this->relevantverdicts as $key => $value){
        if(preg_match($ljnpattern, strtoupper($value))==0){
          unset($this->relevantverdicts[$key]);
        } else {
          $this->relevantverdicts[$key]=trim($value);
          $cnt++;
        };
      };
      return $cnt;
    }
    
    function match($s){
      $this->matchstring=$s;
      $this->matchcount=0;
      for($i=1;$i<=$this->fingercount;$i++){
        $singlew=(count(explode(" ", $this->fingerphrases[$i]))==1);
        $sl=strlen($this->fingerphrases[$i]);
        $lastoffs=-1;
        while(($lastoffs=stripos($s, $this->fingerphrases[$i], $lastoffs+1))){
          $this->matchcount++;
          $this->matchoff[$this->matchcount]=$lastoffs;
          $this->matchlen[$this->matchcount]=$sl;
          $this->matchfingnum[$this->matchcount]=$i;
          if($singlew){
           $singlewordmatchcount++;
          } else {
           $multiwordmatchcount++;
          };
          $this->matchweightssum+=$this->fingerweights[$i];
        };
        
      };
    }
    
    function sw_matches(){
      return $this->singlewordmatchcount;
    }
    
    function mw_matches(){
      return $this->multiwordmatchcount;
    }
    
    function matches(){
      return $this->singlewordmatchcount+$this->multiwordmatchcount;
    }
    
    function matchweight(){
      return $this->matchweightsum;
    }
    
    function is_relevant_verdict($ljn){
      if(count($this->relevantverdicts)==0){
        return FALSE;
      } else {
        return in_array($ljn, $this->relevantverdicts);
      };
    }
    
    function demo_html_code($level){
      if($level>0){
        printf("<table><tr><td> %d </td><td>\n", $level);
      };
      printf("<h2>Titel: %s</h2>\n", $this->title());
      printf("<h2>Uitleg:</h2>\n%s\n\n", $this->explanation());
      printf("<h2>Zoek-document inhoud:</h2>\n");
      if($this->fingerphrases===FALSE){
        printf("Niet beschikbaar of niet leesbaar\n");
      } else {
        printf("<dl>\n");
        foreach($this->fingerphrases as $line_num => $line) {
          printf("<dt>%d</dt><dd>%3d: %s</dd>\n"
                , $line_num
                , $this->fingerweights[$line_num]
                , htmlspecialchars($line)
                );
        };
        printf("</dl>\n");
      };
      printf("<h2>Relevante documenten:</h2>\n");
      printf("<p>Seed doc: %s</p>\n", $this->seeddoc());
      foreach($this->relevantverdicts as $key=>$value){
         printf("<p><a href=\"http://www.rechtspraak.nl/ljn.asp?ljn=%s\">%s</a></p>\n"
               , $value
               , $value
               );
      };
      if($this->superconcepts!=""){
      for($i=0;$i<count($this->superconcepts);$i++){
      printf("<h1>Superieure concepten:</h1>\n");
      $this->superconcepts[$i]->demo_html_code($level+1);
        };
      };
      if($level>0){
        printf("<td></tr></table>\n");
      };
    }
    
    function seeddoc(){
      if(preg_match("/^fp/", $this->uri)>0) return $this->uri;
      $pattern[0]="/:/";
      $replacement[0]=" ";
      return preg_replace($pattern, $replacement, $this->title).".txt";
    }
    
    function collID(){
      if(preg_match("/^fp/", $this->uri)>0){
        return "1770783843";
      } else {
        return "290498218";
      };
    }
    
    
    var $messages;
    var $status;
    
    function rmes(){
      $ret=$this->messages;
      $this->messages="";
      return $ret;
    }
    
    function ames($s){
      $this->messages=$this->messages.$s;
      return $ret;
    }
    
    function reset_status(){
      $this->status=TRUE;
    }
    
    function set_error(){
      $this->status=FALSE;
    }
    
    function object_status(){
      return $this->status;
    }
    
    
  
  }
  
  
?>
