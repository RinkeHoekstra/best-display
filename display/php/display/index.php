<?php
  $currloc=setlocale(LC_ALL,'nl_NL.UTF-8');
  require_once("/home/huygen/BEST/php/rmp.php");
  $rmp=new Rmp();
  global $rmp;
  require_once("/home/huygen/BEST/devroot/lib/vu.cli.best.concepto.php");
  global $conceptset;
  $conceptset=new Conceptset;
  require('xajax/xajax.inc.php');
  $xajax = new xajax(); 
  function printhelemaal($filnam, $entire){
    global $conceptset;
   $objResponse = new xajaxResponse();
   $nextentire=($entire==0 ? 1 : 0);
   if($conceptset->active_concept_count>0){
     $buttontext=($entire==0 ? "Toon document compleet" : "Toon alleen relevante delen");
     $buttonstring='<button onclick=\'xajax_printhelemaal("';
     $buttonstring=$buttonstring.$filnam;
     $buttonstring=$buttonstring.'",';
     $buttonstring=$buttonstring.$nextentire;
     $buttonstring=$buttonstring.')\'>'.$buttontext.'</button>';
     $objResponse->addAssign("textmodebutton","innerHTML", $buttonstring);
   };
   $objResponse->addAssign("textselectionbuttontext","innerHTML", $buttontext);
   $objResponse->addAssign("verdictplace","innerHTML",printannotatedverdict($filnam,$entire));
   return $objResponse;
  }
  
  $xajax->registerFunction("printhelemaal");
  
  $xajax->processRequests();
  
  
  $paginatitel="Display";
?>
<!DOCTYPE html 
     PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="nl" lang="nl">
  <head>
    <?php
      $xajax->printJavascript('/xajax');
      
    ?>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <meta content="Paul Huygen (p.e.m.huygen@cli.vu)" name="Author"/>
    <title>
      <?php printf("%s\n", $paginatitel); ?>
    </title>
    <link rel="stylesheet" type="text/css" href="http://cli.vu//best/display/css/best.css"/>
    
  </head>
  <body>
    <!-- **** top of the page **** -->
    <table width="100%">
     <tr>
       <td>
        <div class="bannerheading">Wat is mijn positie?
        </div>
        <div class="bannersubheading">
          Prototype
        </div>
       </td>
       <td>
         <img src="http://cli.vu//plaatjes/best-logo.gif" width="80" 
                               hspace="10"  align="right"
            alt="BEST logo"/>
       </td>
     </tr>
    </table>
    
    <!-- **** Navigation Bar **** -->
    <div id="navigation">
     <a class=ord href="<?php printf("%s", $_SERVER["PHP_SELF"]); ?>" 
        title="Begin opnieuw">Opnieuw</a> | 
     <?php helpbutton() ?> |
     <a class=ord href="http://www.best-project.nl" 
        title="BEST-project Home">Best</a> | 
    </div>
    
    <div id="content">
      <?php content();?>
    </div>
    
    <div id="footer">
        Versie van 10-03-2009, 1407
      
      <a class=ord href="http://validator.w3.org/check/referer">
      <img class="cert"
           src="http://cli.vu//plaatjes/valid-xhtml10.gif"
           alt="Valid XHTML 1.0?"/>
      </a> 
      
    </div>
    
    
    <?php
      printf("<script type=\"text/javascript\" src=\"http://cli.vu//javascripts/wz_tooltip.js\"></script>\n");
      if(parameter_value_of('dispfil')!=""){
        printf("<script type=\"text/javascript\">\n");
        printf("xajax_printhelemaal(\"%s\",0)\n", parameter_value_of('dispfil'));
        printf("</script>\n");
      };
      
    ?>
  </body>
</html>
<?php
  function content(){
    if(parameter_value_of('mode')=="c"){
        display_conceptorientedmode();
    } else {
      if(parameter_value_of('mode')=="d"){
        display_documentorientedmode();
      } else { 
          display_nomode();
      };
    };
    
  };
  function display_nomode(){
    printf("<h1>Kies een presentatievorm</h1>");
    ?>
    <h2>Concept-georienteerde modus</h2>
    <p> In deze modus selecteert u een concept uit een lijst in het
    linkerpaneel. U krijgt dan uitleg over deze modus en u krijgt een lijst van
    uitspraken waarin dit concept relevant is. U kunt een bestand in
    zijn geheel laten
    presenteren op het scherm of alleen de passages waarin het concept
    aan de orde komt.
    </p>
       <a class=ord href="<?php
           printf("%s", address_with_modified_querystring("mode", "c"));
           ?>"
       >
            Ik wil de concept-georienteerde modus.
       </a>
    <?php
    
    if(parameter_value_of('concept1')==""){
      ?>
      <h2>Document-georienteerde modus</h2>
      <p> In deze modus selecteert u de tekst van een rechterlijke uitspraak uit een lijst in het
      linkerpaneel. Deze uitspraken zijn gerelateerd aan een
      (hypothetische) casus en de concepten van die casus zijn ook
      relevant in deze uitspraken. 
      
      Als u een van deze uitspraken aanklikt, dan wordt deze afgedrukt, samen
      met een lijst relevante concepten. Als u concepten aanklikt, dan lichten
      de passages in het document die over dat concept gaan op.
      
      U kunt kiezen uit verschillende groepen van documenten met bijbehorende concepten:
      </p>
      <?php
      
      ?>
      <div align="LEFT">
      <table CELLPADDING=3 BORDER="1">
       <tr>
         <th> Casus (concept nrs):</th>
         <th> Casus (concept nrs):</th>
         <th> Casus (concept nrs):</th> 
       </tr>
       <?php
          create_cases_table();
       ?>
      </table>
      </div>
      <?php
      
    } else {
      ?>
      <h2>Document-georienteerde modus</h2>
      <p> In deze modus selecteert u de tekst van een rechterlijke uitspraak uit een lijst in het
      linkerpaneel. Deze uitspraken zijn gerelateerd aan een
       casus en de concepten van die casus zijn ook
      relevant in deze uitspraken. 
      </p>
      <?php
      
      printf( "<p><a class=ord href=\"%s\">%s</a></p>\n"
            , address_with_modified_querystring("mode", "d")
            , "Ik wil de document-georienteerde modus"
            );
      
    };
    
  }
  function display_conceptorientedmode(){
    ?>
    <table width="100%">
      <tr>
        <td width="200px"  valign="top">
         <?php concepto_leftpanelcontent();?>
        </td> 
        <td  valign="top">
         <?php concepto_rightpanelcontent();?>
        </td> 
      </tr>   
    </table>
    <?php
  }
  function concepto_leftpanelcontent(){
    global $conceptset;
    
    printf(" <h2>Aspecten van uw probleem</h2>\n");
    if(count($conceptset->conceptcount())<=0){
      printf("<p>Uw probleem heeft geen interessante aspecten.\n");
      printf("Als u het zelf niet kunt oplossen kunt u het beste\n");
      printf("een advocaat bellen.</p>\n");
    }else{
      printf("<p>Uw probleem heeft de volgende aspecten.\n");
      printf("Klik op een aspect om er meer informatie over\n");
      printf("te krijgen:</p>\n");
      printf("<ul>\n");
      for($i=1;$i<=$conceptset->conceptcount();$i++){
        printf("<li>%s\n",  pointer_to_single_concept($i));
      
      };
      printf("</ul>\n");
      
    };
    
  }
  
  function pointer_to_single_concept($conceptnum){
    global $conceptset;
    $conc=$conceptset->concept($conceptnum);
    $questr=$conceptset->querystring_with_conceptnr($conceptnum, "c");
    $questr=remove_filename_from_querystring($questr);
    $returnstring
        = reference_with_tooltips(
             $conc->title(),
             $conc->explanation(),
             "http://cli.vu//best/display/index.php?".$questr
          );
    return $returnstring;
  };
  
  function concepto_rightpanelcontent(){
    global $conceptset;
    if($conceptset->active_concept_count==0){
      printf("<p>Klik op een aspect in het linker venster</p>\n");
      return;
    };
    $conc=$conceptset->active_concept(0);
    printf("<h2>%s</h2>\n", $conc->title());
    printf("%s\n", $conc->explanation());
    
    printf("<hr>\n");
    if(count($conc->verdicts())<=0){
      printf("Er zijn geen relevante uitspraken bekend.\n");
    } else {
      foreach($conc->verdicts() as $key => $verdid){
        $questr=modified_querystring('dispfil',trim($verdid));
        printf("<a class=ord href=\"http://cli.vu//best/display/index.php?%s\">%s</a> ",$questr, $verdid); 
      };
    };
    
    printf("<hr>\n");
    $filnam=parameter_value_of('dispfil');
    if($filnam==""){
      printf("<p>Klik op een bestandsnaam om hem in dit venster te zien.</p>\n");
    } else {
      printf("<p align=\"center\">\n");
       printf("<div id=\"textmodebutton\"></div>");
       
      printf("</p>\n");
       printf("<h2>Uitspraak %s</h2>\n", $filnam);
      printf("<div id=\"verdictplace\"></div>\n");
      
      
    };
  };
  function create_cases_table(){
    $filenamepattern="/^FP.*[^~]$/";
    $colnum=1;
    $dir=opendir("/home/huygen/BEST/display/resources/casegroups");
      while(($file = readdir($dir)) !== false){
        if(preg_match($filenamepattern, $file)>0){
          $filepath="/home/huygen/BEST/display/resources/casegroups/".$file;
          if($colnum==1) printf("<tr>\n");
          $questarr=array("mode" => "d", "cl" => $file);
          $questr=http_build_query($questarr);
          
          $handle=fopen($filepath, "rb");
          $conceptnrs=fgets($handle);
          fclose($handle);
          
          printf("  <td><a class=ord href=\"index.php?%s\">%s</a> (%s)</td>\n",
                  $questr,$file, $conceptnrs
                );
          if($colnum==3){
              printf("<tr>\n");
              $colnum=1;
          } else {
            $colnum++;
          };
        };
      }
    closedir($dir);
  }
  function display_documentorientedmode(){
    ?>
    <table width="100%">
      <tr>
        <td width="200px"  valign="top">
         <?php documento_leftpanelcontent();?>
        </td> 
        <td  valign="top">
         <?php documento_rightpanelcontent();?>
        </td> 
      </tr>   
    </table>
    <?php
  }
  function documento_leftpanelcontent(){
    global $conceptset;
    $ljn=parameter_value_of('dispfil');
    if($ljn!=""){
      $helptext="Hieronder staan juridische aspecten die op uw ";
      $helptext=$helptext."probleem betrekking hebben. ";
      $helptext=$helptext."Door op de bijbehorende &quot;aan&quot; te klikken ";
      $helptext=$helptext."kunt u zien voor welke passages in de tekst ";
      $helptext=$helptext." dit aspect belangrijk is.";
      
      printf("<H2>%s</H2>\n", tooltippeds("Aspecten", $helptext));
      
      $conceptcount=0;
      if($conceptset->active_concept_count()>0){
        $helptext="Onderstaande aspecten zijn voor uw probleem relevant. ";
        $helptext=$helptext."De passages in de uitspraak in het rechterpaneel ";
        $helptext=$helptext." waarin dit aspect relevant is zijn gekleurd weergegeven ";
        $helptext=$helptext." Door op &quot;uit&quot; te klikken kunt u de kleuring ";
        $helptext=$helptext."uitzetten.";
        
        printf("<H3>%s</H3>\n", tooltippeds("geselecteerd", $helptext));
        
        printf("<table>\n");
        $conc=$conceptset->first_active_concept();
        while(!$conc===FALSE){
          $conceptcount++;
          printf("<tr>\n");
          printf("  <td>%d</td>\n", $conceptcount);
          printf("  <td>%s</td>\n", uitzetknop($conceptset->current_active_conceptkey() ));
          printf("  <td>%s</td>\n", active_conceptlabel($conc,$conceptcount));
          printf("</tr>\n");
          
          
          $conc=$conceptset->next_active_concept();
        };
        if($conceptcount>1){
          if($conceptcount>=2){
            printf("<tr>\n");
            printf("  <td /><td /><td><span class=\"ponetwo  \">1 en 2</span></td>\n");
            printf("</tr>\n");
          };
          if($conceptcount>=3){
            printf("<tr>\n");
            printf("  <td /><td /><td><span class=\"ponethree  \">1 en 3</span></td>\n");
            printf("</tr>\n");
            printf("<tr>\n");
            printf("  <td /><td /><td><span class=\"ptwothree  \">2 en 3</span></td>\n");
            printf("</tr>\n");
            printf("<tr>\n");
            printf("  <td /><td /><td><span class=\"ponetwothree  \">1, 2 en 3</span></td>\n");
            printf("</tr>\n");
          };
          
        };
        printf("</table>\n");
        
      };
      if(nonactive_concepts_remaining($ljn)){
        $helptext="Onderstaande aspecten zijn voor uw probleem relevant";
        $helptext=$helptext." Door bij maximaal~3 aspecten op";
        $helptext=$helptext." &quot;aan&quot; te klikken kunt u in de uitspraak ";
        $helptext=$helptext." in het rechterpaneel passages die over dit aspect gaan ";
        $helptext=$helptext." gekleurd laten weergeven.";
        
        printf("<H3>%s</H3>\n", tooltippeds("niet geselecteerd", $helptext));
        
        printf("<table>\n");
        $conc=$conceptset->first_nonactive_concept();
        while(!($conc===FALSE)){
          if($conc->is_relevant_verdict($ljn)){
            $conceptcount++;
            printf("<tr>\n");
            printf("  <td>%d</td>\n", $conceptcount);
            printf("  <td>%s</td>\n", aanzetknop($conceptset->current_conceptkey()));
            printf("  <td>%s</td>\n", non_active_conceptlabel($conc,$conceptcount));
            printf("</tr>\n");
            
            
          };
          $conc=$conceptset->next_nonactive_concept();
        }
        printf("</table>\n");
        
      };
      
    };
    $helptext="Hieronder staan rechterlijke uitspraken over ";
    $helptext=$helptext."zaken die op uw zaak lijken. ";
    $helptext=$helptext."Als u er een van aanklikt zal hij ";
    $helptext=$helptext."afgedrukt worden in het rechterpaneel.";
    
    printf("<H2>%s</H2>\n", tooltippeds("Verwante zaken", $helptext));
    
    $clusterlist=parameter_value_of('cl');
    if($clusterlist==""){
      $conc=$conceptset->first_concept();
      $verdar=array();
      while(!($conc===FALSE)){
        if(count($conc->verdicts())>0){
          foreach($conc->verdicts() as $key => $verdict){
            if(!in_array($verdict, $verdar)){
              $verdar[]=$verdict;
            };
          };
        };
        $conc=$conceptset->next_concept();
      };
      sort($verdar);
      
      foreach($verdar as $key => $verdict){
        printf("<li>");
        printf( "<a class=ord href=\"index.php?%s\">%s</a>\n"
              , modified_querystring('dispfil',$verdict)
              , $verdict
              );
        
        printf("</li>\n");
      };
      
      
    } else {
      if($handle=fopen("/home/huygen/BEST/display/resources/casegroups/".$clusterlist, "rb")){
        $fpnums=fgets($handle);
        printf("<ul>\n");
         while(!feof($handle)){
           $verdict=trim(fgets($handle));
           if(preg_match("/^[A-Z]/i", $verdict)>0){
             printf("<li>");
             printf( "<a class=ord href=\"index.php?%s\">%s</a>\n"
                   , modified_querystring('dispfil',$verdict)
                   , $verdict
                   );
             
             printf("</li>\n");
           };
         };
        printf("</ul>\n");
        fclose($handle);
      };
      
    };
    
  }
  
  function nonactive_concepts_remaining($ljn){
    global $conceptset;
    $conc=$conceptset->first_nonactive_concept();
    if($conc===FALSE) return FALSE;
    while(TRUE){
      if($conc->is_relevant_verdict($ljn)) return TRUE;
      $conc=$conceptset->next_nonactive_concept();
      if($conc===FALSE) return FALSE;
    };
  }
    
  function aanzetknop(){
   global $conceptset;
   $conceptkey=$conceptset->current_conceptkey();
   $questr=$conceptset->querystring_with_conceptnr($conceptkey, "d");
   return "<a class=ord href=\"http://cli.vu//best/display/index.php?".$questr."\">Sel.</a>"; 
  }
  function uitzetknop($connum){
   global $conceptset;
   $questr=$conceptset->querystring_without_conceptnr($connum);
   return "<a class=ord href=\"http://cli.vu//best/display/index.php?".$questr."\">Unsel.</a>"; 
  }
  function non_active_conceptlabel($conc, $actnum){
    global $conceptset;
    return tooltippeds($conc->title(), $conc->explanation());
  
  }
  
  function active_conceptlabel($conc, $actnum){
    $frasn="f".telwoordvan($actnum);
    return "<span class=\"".$frasn."\">"
           .tooltippeds($conc->title(), $conc->explanation())
           ."</span>\n";
  
  }
  
  function documento_rightpanelcontent(){
    $filnam=parameter_value_of('dispfil');
    if($filnam==""){
      printf("<p>In het linkerpaneel staan de LJN nummers van
      rechterlijke uitspraken van zaken die verwant zijn aan de uwe.</p>\n");
      printf("<p>Klik op een van de codes om een zaak in te zien.</p>\n");
    } else {
      printf("<p align=\"center\">\n");
       printf("<div id=\"textmodebutton\"></div>");
       
      printf("</p>\n");
       printf("<h2>Uitspraak %s</h2>\n", $filnam);
      printf("<div id=\"verdictplace\"></div>\n");
      
      
    };
  };
  function helpbutton(){
    if(parameter_value_of('mode')=="c"){
      $helptextfil="/home/CLI/www/best/display/help/conceptmodehelp";
    } else {
      if(parameter_value_of('mode')=="d"){
        $helptextfil="/home/CLI/www/best/display/help/documentmodehelp";
      } else { 
        $helptextfil="/home/CLI/www/best/display/help/generalhelp";
      };
    };
    
    if(file_exists($helptextfil)){
      $general_helptext=preprocessed_tooltiptext(file_get_contents($helptextfil));
    } else {
       $general_helptext="Help tekst is nu niet beschikbaar";
    };
    tooltipped("Help", $general_helptext);
    
  }
  
  function printannotatedverdict($filename, $entire){
    global $conceptset;
      $irrelsecnum=0;
    
    $uittext="";
    if($conceptset->active_concept_count>0){
      $conc=$conceptset->active_concept(0);
    };
    $uittext=$uittext.display_textsegment($filename, "I", $entire);
    $uittext=$uittext.display_textsegment($filename, "U", $entire);
    $uittext=$uittext.display_textsegment($filename, "C", $entire);
    $explaintext = new Explaintexts;
    $uittext=$explaintext->wordtotooltip($uittext);
    
    return $uittext;
  };
  function display_textsegment($filnam, $seg, $entire){
    global $conceptset;
    global $rmp;
    $tokob=new Seqtoks($filnam, $seg);
    if($tokob->parcount()<=1) return "";
    if($seg=="I"){
      $seqn="Indicatie";
    } else {
      if($seg=="U"){
        $seqn="Uitspraak";
      } else {
        $seqn="Conclusie";
      }
    };
    $uits=$uits."<h2>".$seqn."</h2>\n";
    
    $annotate=($conceptset->active_concept_count>0);
    $entire=($entire || !($annotate));
    if($annotate){
      $conc=$conceptset->first_active_concept();
      $aconcnum=0;
      while(!$conc===FALSE){
        $aconcnum++;
        $tokob->match_phrases_of($conc, $aconcnum);
        $conc=$conceptset->next_active_concept();
      };
      $tokob->find_matchpoints();
    };
    $tokob->initprint();
    while($tokob->still_paragraphs_to_print()){
      if($annotate){
        $rel_ar=$tokob->relevances_of_current_paragraph();
        $is_relevant=($rel_ar[1] || $rel_ar[2] || $rel_ar[3]);
      };
      if($entire || $is_relevant) $uits=$uits."<p>";
      if($is_relevant) $uits=$uits."\n<span class=\"".generate_spanlabelname($rel_ar)."\">\n";
      $uits=$uits.$tokob->next_paragraphtext($entire, $is_relevant, $annotate);
      if($is_relevant) $uits=$uits."\n</span><br>\n";
      if($rel_ar[1]){
        
      };
      if($is_relevant) $uits=$uits."</p>\n";
      
    };  
    
    return $uits;
  }
  
  function generate_spanlabelname($rel_ar){
    $uits="p";
    for($i=1;$i<=3;$i++){
      if($rel_ar[$i]) $uits=$uits.telwoordvan($i);
    };
    return $uits;
  }
  class Seqtoks{
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
  
  
  var $tokenlist; // Note: first token is nr. 1.
  var $nrtokens;
  var $sentencelist;
  var $paragraphlist;
  var $ljn;
  var $seg;
  var $parrec;
  var $matches;
  var $nrmatches;
    var $matchpoints=array();
  var $matchconcepts;
  var $stagtal;
  var $next_string_edge = 0;
  var $matchstringcount=array( 1 => 0, 2 => 0, 3 => 0);
  
  function __construct($did, $textseg){
    global $rmp;
    $this->ljn=$did;
    $this->seg=$textseg;
    $this->tokenlist=$rmp->tokenlist_of($this->ljn, $this->seg);
    $this->nrtokens=count($this->tokenlist["offset"]);
    $this->sentencelist=$rmp->sentencelist_of($this->ljn, $this->seg);
    $this->paragraphlist=$rmp->paragraphlist_of($this->ljn, $this->seg);
    $this->matches=FALSE;
    $this->nrmatches=0;
    
  }
  function initprint(){
    reset($this->paragraphlist["first"]);
    reset($this->paragraphlist["last"]);
    if(current($this->paragraphlist["first"])===FALSE){
      $this->parrec=FALSE;
    } else {
      $this->parrec=array( "first" => current($this->paragraphlist["first"])
                          ,  "last" => current($this->paragraphlist["last"])
                          );
    };
    
    return $this->parrec;
  }
  
  function still_paragraphs_to_print(){
    return ($this->parrec===FALSE ? FALSE : TRUE);
  }
  function next_paragraphtext($entire, $is_relevant, $annotate){
    if($entire || $is_relevant){
      $bol=TRUE;
      for($i=$this->parrec["first"];$i<=$this->parrec["last"];$i++){
        if($this->tokenlist["text"][$i]){
          if(!$bol) $uits=$uits." ";
          $tokenstr=token_word( $this->tokenlist["casus"][$i]
                                  , $this->tokenlist["text"][$i]
                                  , $this->tokenlist["class"][$i]
                                  );
        } else {
          $tokenstr=$this->tokenlist["class"][$i];
        };
        $uits=$uits.( $annotate
                      ? $this->annotate_token($tokenstr,$i)
                      : $tokenstr
                      );
        
        $bol=FALSE;
      };
    } else {
      $uits="...";
    };
    next($this->paragraphlist["first"]);
    next($this->paragraphlist["last"]);
    if(current($this->paragraphlist["first"])===FALSE){
      $this->parrec=FALSE;
    } else {
      $this->parrec=array( "first" => current($this->paragraphlist["first"])
                          ,  "last" => current($this->paragraphlist["last"])
                          );
    };
    
    while($this->next_string_edge<$this->parrec["first"]) $this->next_matchpoints_element();
    //Test:
    return $uits;
  }
  function paroftok($toknum){
    $lastkey="";
    foreach($this->paragraphlist as $key => $num){
      if($toknum>$num){
        if($lastkey==""){
          return $key;
        } else {
          return $lastkey;
        };
      };
      $lastkey=$key;
    };
  }
  
  function testit(){
    global $rmp;
    $uits="<p>ID van seg. \"".$this->seg."\" van ".$this->ljn.": ";
    $uits=$uits.$rmp->id_of_subtext($this->ljn, $this->seg)."</p>\n";
    $uits=$uits."<p>Aantal tokens: ".count($this->tokenlist);
    return $uits;
  }
  function parcount(){
    return count($this->paragraphlist["first"]);
  }
  function match_phrases_of($conc, $num){
    $phrases=$conc->fingerphrases();
    $weights=$conc->fingerweights();
    foreach($phrases as $key => $phrase){
      $this->match_string($phrase, $weights[$key], $key, $num);
    };
  }
  
  function match_string($phrase, $weight, $pnum, $cnum){
    global $rmp;
    if($phrase===FALSE) return;
    $sphrases=$rmp->get_stemmed_words(preg_split("/ +/", $phrase));
    $tptr=1;
    while($tptr+count($sphrases)<$this->nrtokens){
      $wd=reset($sphrases);
      $ttptr=$tptr;
      while(TRUE){
        $partmatch=($wd==$this->tokenlist["stem"][$ttptr]);
        if(!$partmatch) break;
        $wd=next($sphrases);
        if($wd===FALSE) break;
        $ttptr++;
      };
      if($partmatch){
              $this->nrmatches++;
              $this->matches["parnum"][$this->nrmatches]=$this->paroftok($tptr);
              $this->matches["firsttok"][$this->nrmatches]=$tptr;
              $this->matches["lasttok"][$this->nrmatches]=$ttptr;
              $this->matches["cn"][$this->nrmatches]=$cnum;
              $this->matches["pn"][$this->nrmatches]=$pnum;
              $this->matches["wt"][$this->nrmatches]=$weight;
        
      };
      $tptr++;
    };
  }
  
  function matchreport(){
    $uits="<p>Number of matches: ".$this->nrmatches."</p>";
    if($this->nrmatches>0){
      $uits=$uits."<p>";
      for($i=$this->matches["firsttok"][1];$i<=$this->matches["lasttok"][1];$i++){
        $uits=$uits." ".$this->tokenlist["text"][$i];
      };
      $uits=$uits."</p>";
    };
    return $uits;
  }
  
  function relevances_of_current_paragraph(){
    $weights[1]=0;$weights[2]=0;$weights[3]=0;
    for($i=1;$i<=$this->nrmatches;$i++){
      if(     $this->matches["firsttok"][$i]>=$this->parrec["first"]
          &&  $this->matches["firsttok"][$i]<=$this->parrec["last"]
        ){
       $weights[$this->matches["cn"][$i]]+=$this->matches["wt"][$i];
      };
    };
    $weightsum=array_sum($weights);
    $tr=0;
    for($i=0;$i<3;$i++){
      $rel[$i]=($weights[$i] > 100);
      if($rel[$i])$tr++;
    };
    if($tr>0){
      $tr=0;
      for($i=0;$i<3;$i++){
        $rel[$i]=($weights[$i] > 50);
        if($rel[$i])$tr++;
      };
    };
    return $rel;
  }
  
  function find_matchpoints(){
    unset($this->matchpoints);
    $this->matchpoints=array();
    $found=0;
    for($i=1;$i<=$this->nrmatches;$i++){
      $found++;
      $ft=$this->matches["firsttok"][$i];      
      $lt=$this->matches["lasttok"][$i];
      $cn=$this->matches["cn"][$i];
      if($ft==$lt){
        if($this->matchpoints[$ft][$cn]==""){
          $this->matchpoints[$ft][$cn]="*";
        };
        
      } else {
        switch($this->matchpoints[$ft][$cn]){
          case "":
          case "*":
            $this->matchpoints[$ft][$cn]=1;
            break;
          default:
            $this->matchpoints[$ft][$cn]++;
        };
        
        switch($this->matchpoints[$lt][$cn]){
          case "":
          case "*":
            $this->matchpoints[$lt][$cn]=-1;
            break;
          default:
            $this->matchpoints[$lt][$cn]--;
        };
        
      };
      
    };
    ksort($this->matchpoints);
    $this->reset_matchpoints_array();
  }
  function report_matchpoints(){
    $uits="<table>";
    foreach($this->matchpoints as $toknum => $value){
      $uits=$uits."<tr><td>".$toknum."</td><td>".$this->tokenlist["text"][$toknum]."</td>";
      for($i=1;$i<=3;$i++){
         $uits=$uits."<td>".(($value[$i]=="") ? "." : $value[$i])."</td>";
      }
      $uits=$uits."</tr>\n";
    };
    $uits=$uits."</table>";
    reset($this->matchpoints);
    return $uits;
  }
  function reset_matchpoints_array(){
    if(reset($this->matchpoints)===FALSE){
     $this->next_string_edge=$this->nrtokens+1;
    } else {
     $this->next_string_edge=key($this->matchpoints);
    };
    return $this->next_string_edge;
  }
  
  function next_matchpoints_element(){
    if(next($this->matchpoints)===FALSE){
     $this->next_string_edge=$this->nrtokens+1;
    } else {
     $this->next_string_edge=key($this->matchpoints);
    };
    return $this->next_string_edge;
  }
  
  function annotate_token($tk,$toknum){
      $tok=$tk;
    if($toknum>=$this->next_string_edge){
      $mpar=current($this->matchpoints);
      $beginrelevances=$this->matchstringcount;
      $endrelevances=$this->matchstringcount;
      for($i=1;$i<=3;$i++){
        for($i=1;$i<=3;$i++){
          $val=$mpar[$i];
          if(!($val=="")){
            if($val=="*"){
         $beginrelevances[$i]++;
            } else {
              if($val>0){
           $beginrelevances[$i]++;
           $endrelevances[$i]++;
         } else {
                if($val<0){
             $endrelevances[$i]--;
                };
              };
            };
     };
        };
      };
      $changed=FALSE;
      foreach($this->matchstringcount as $key => $value){
        if( ($this->matchstringcount[$key]>0)  && ($beginrelevances[$key]<=0)
                           ||
            ($this->matchstringcount[$key]<=0) &&  ($beginrelevances[$key]>0)
          ){
          $changed=TRUE;
          break;
        };
      };
      
      if($changed){
        $inmatch=FALSE;
        foreach($this->matchstringcount as $key => $value){
          if($value>0){
            $inmatch=TRUE;
            break;  
          };
        };
        
        $tok=($inmatch ? "</span>" : "")."<span class=\"".$this->spanclassof($beginrelevances)."\">".$tok;
        
      };
      
      $changed=FALSE;
      foreach($beginrelevances as $key => $value){
        if( ($beginrelevances[$key]>0)  && ($endrelevances[$key]<=0)
                           ||
            ($beginrelevances[$key]<=0) &&  ($endrelevances[$key]>0)
          ){
          $changed=TRUE;
          break;
        };
      };
      
      if($changed){
          
          $tok=$tok."</span>".($inmatch ? "<span class=\"".$this->spanclassof($endrelevances)."\">" : "");
        
      };
      
      $this->matchstringcount=$endrelevances;
      $this->next_matchpoints_element();
    };
    return $tok;
  }
  
  function spanclassof($relar){
    $lab="f";
    foreach($relar as $key => $value){
      if($value>0) $lab=$lab.telwoordvan($key);
    };
    return $lab;
  }
  
  } // End of Seqtoks class
  function token_word($casus, $text, $class){
    if(!$text) return $class; 
    switch($casus){
     case "U":
       $retval=strtoupper($text);
       break;
     case "C":
       $retval=ucfirst($text);
       break;
     default:
       $retval=$text;
    };
    return $retval;
  }
  
  function old_pointer_to_single_concept($conceptnum, $helpobj){
    $sconceptset=new Conceptset;
    $active=$sconceptset->is_active_concept($conceptnum);
    if ($handle = fopen("/home/huygen/BEST/concepts/fp".$conceptnum, "rb")) {
        $concepttitle=rtrim(fgets($handle));
        $sconceptset->make_empty();
        $questr=$sconceptset->querystring_with_conceptnr($conceptnum, "c");
        $questr=remove_filename_from_querystring($questr);
        fclose($handle);
        if($active){
            $returnstring=$concepttitle;
        } else {
          $returnstring=" <a class=pah ";
          $returnstring=$returnstring.$helpobj->onmouseoverriedel($conceptnum);
          $returnstring=$returnstring." href=\"http://cli.vu//best/display/index.php?".$questr."\">";
          $returnstring=$returnstring.$concepttitle;
          $returnstring=$returnstring."</a>";
        };
    } else {
       $returnstring="concept ".$conceptnum." isterniet.";
    };
    return $returnstring;
  }
  
 function telwoordvan($i){
   switch($i){
     case 0: return "nul";
     case 1: return "one";
     case 2: return "two";
     case 3: return "three";
     case 4: return "four";
     case 5: return "five";
     case 6: return "six";
     case 7: return "seven";
     case 8: return "eight";
     case 9: return "nine";
   };
   return;
 }
 function parameter_value_of($parnam){
   parse_str($_SERVER['QUERY_STRING'], $params);
   return $params[$parnam];
 }
 
 function modified_querystring($parnam, $parval){
   return  cascmodified_querystring($_SERVER['QUERY_STRING'], $parnam, $parval);
 }
 
 function cascmodified_querystring($ques, $parnam, $parval){
   parse_str($ques, $params);
   if($parval==""){
     unset($params[$parnam]);
   } else {
     $params[$parnam]=$parval;
   };
   return http_build_query($params);
 }
 
 function address_with_modified_querystring($parnam, $parval){
   return $_SERVER["PHP_SELF"]."?".modified_querystring($parnam, $parval);
 }
 function address_with_unmodified_querystring(){
   return $_SERVER["PHP_SELF"]."?".$_SERVER['QUERY_STRING'];
 }
 function remove_filename_from_querystring($questr){
   parse_str($questr, $params);
   unset($params["dispfil"]);
   return http_build_query($params);
 }
 
 function tooltipped($doctext, $tttext){
   printf("<a class=nepa onmouseover=\"Tip('%s')\">%s</a>\n", $tttext, $doctext);
 }
 
 function tooltippeds($doctext, $tttext){
   return "<a class=nepa onmouseover=\"Tip('".$tttext."')\">".$doctext."</a>\n"; 
 }
 function reference_with_tooltips($text, $tttext, $target){
   $rets=       "<a class=pah ";
   $rets=$rets.  "onmouseover=\"Tip('".preprocessed_tooltiptext($tttext)."')\" ";
   $rets=$rets.  "href='".$target."'";
   $rets=$rets.">";
   $rets=$rets.  $text;
   $rets=$rets."</a>";
   return $rets;
 }
 
 function preprocessed_tooltiptext($intext){
   $pattern=array(0 => "/\n/", 1 =>"/\"/");
   $replacement=array(0 => " ", "&quot;");
   ksort($pattern);
   ksort($replacement);
   return preg_replace($pattern, $replacement, $intext);
 }
 
 class Helptext {
   var $texts;
   var $empty=TRUE;
 
   function Helptext(){
     $this->texts[0]="empty";
   }
 
   function fill_with_file($filnam){;
     unset($this->texts);
     $this->empty=TRUE;
     if($handle=fopen($filnam,  "rb")){
       $this->empty=feof($handle);
       while(!feof($handle)){
         $linarr = explode("\t", rtrim(fgets($handle)));
         if($linarr[0]!=""){
           $this->texts[$linarr[0]]=$linarr[1];
         };
       };
       fclose($handle);
     };
   }
   
   function save($filpath){
     $backupfilpath=$filpath.".old";
     if (!copy($filpath, $backupfilpath)) {
       printf("<p> Kopie van %s naar %s maken is mislukt. </p>\n", $filpath,  $backupfilpath);
     } else {
       if($handle = fopen($filpath, "w")){
         foreach($this->texts as $key => $value){
           $outs=$key."\t".$value."\n";
           fwrite($handle, $outs);
         };
         fclose($handle);
         return TRUE;
       } else {
         return FALSE;
       };
     };
   }
   
   function gettext($item){
     return $this->texts[$item];
   }
   
   function printtooltip($pointer, $label){
     tooltipped($label, $this->texts[$pointer]);
   }
   
   function onmouseoverriedel($pointer){
     return "onmouseover=\"Tip('".$this->texts[$pointer]."')\"";
   }
   
   
 }
 
 class Concepthelptext extends Helptext{
   var $chelpfilnam="/home/CLI/www/best/display/help/concepthelp";
 
   function Concepthelptext(){
     parent::fill_with_file($this->chelpfilnam);
   }
   function save(){
     return parent::save($this->chelpfilnam);
   }
   function insert_text($ptr, $text){
     $this->texts[$ptr]=$text;
     $this->save();
   }
   
   function printtooltip($pointer){
     $concepttitle=concepttitle($pointer);
     tooltipped($concepttitle, $this->texts[$pointer]);
   }
   
   function tooltipstring($pointer){
     $concepttitle=concepttitle($pointer);
     return tooltippeds($concepttitle, $this->texts[$pointer]);
   }
   
 
 }
 class Explaintexts{
   var $words;
   var $explanations;
   var $wordcount;
   var $wordsstored=0;
   var $wordpointer=1;
 
 function Explaintexts(){
   $this->wordsstored=0;
   if($legahandle = fopen("/home/huygen/BEST/misc/legalese.txt", "rb")){
     while(!feof($legahandle)){
       $legarr = explode("\t", rtrim(fgets($legahandle)));
       if($legarr[0]!=""){
         $this->wordsstored++;
         $this->words[$this->wordsstored]=$legarr[0];
         $this->explanations[$this->wordsstored]=$legarr[1];
       };
     };
     fclose($legahandle);
   };
 }
 
 function save(){
   $backupfilpath= "/home/huygen/BEST/misc/legalese.txt".".old";
   if (!copy("/home/huygen/BEST/misc/legalese.txt", $backupfilpath)) {
     printf("<p> Kopie van %s naar %s maken is mislukt. </p>\n",
                  "/home/huygen/BEST/misc/legalese.txt",  $backupfilpath
           );
     return FALSE;
   };
   if($handle = fopen("/home/huygen/BEST/misc/legalese.txt", "w")){
     $this->reset();
     while($this->getnextword()!=""){
       $outs=$this->words[$this->wordpointer]."\t".$this->explanations[$this->wordpointer]."\n";
       fwrite($handle, $outs);
     };
     fclose($handle);
     return TRUE;
   };
 }
 
 function wordcount(){
   return $this->wordsstored;
 }
 
 function reset(){
   for($i=1;$i<=$this->wordsstored; $i++) $this->wordcount[$i]=0;
   $this->wordpointer=0;
   return;
 }
 function getnextword(){
  if($this->wordpointer<=$this->wordsstored) $this->wordpointer++;
  if($this->wordpointer>$this->wordsstored){
    return "";
  } else {
    return $this->words[$this->wordpointer];
  };
 }
 function getcurrentword(){
  if($this->wordpointer>$this->wordsstored){
    return "";
  } else {
    return $this->words[$this->wordpointer];
  };
 }
 function make_current_word($word){
   $this->reset();
   while(($this->getnextword()!="") && ($this->getcurrentword()!=$word)){
   };
   return $this->getcurrentword();
 }
 
 function getexplanation(){
  if($this->wordpointer>$this->wordsstored){
    return "";
  } else {
    return $this->explanations[$this->wordpointer];
  };
 }
 function report_times_found($times){
  $this->wordcount[$this->wordpointer]+=$times;
 }
 
 function times_found(){
  return $this->wordcount[$this->wordpointer];
 }
 
 function explain_texts(){
   $texts="";
   if($this->wordsstored<=0) return "<h1>niks-schrijven</h1>";
   for($i=1; $i<=$this->wordsstored; $i++){
     if($this->wordcount[$i]>0){
       $texts=$texts."<span id=\"".$this->words[$i]."\">".
               $this->explanations[$i].
               "</span>\n";
     };
   };
   return $texts;
 }
 
 function onmouseoverriedel(){
   return "onmouseover=\"Tip('".$this->getexplanation()."')\"";
 }
 
 function wordtotooltip($instr){
   $this->reset();
   $i=1;
   while($this->getnextword()!=""){
    $legawoord=$this->getcurrentword();
       $pattern=array(
              0 => "/".strtolower($legawoord)."/",
              1 => "/".ucfirst($legawoord)."/",
              2 => "/".strtoupper($legawoord)."/"
       );
    
    $replastring="<a class=nepa ";
    $replastring=$replastring.$this->onmouseoverriedel();
    $replastring=$replastring.">";
    $replastring=$replastring."aapnootMies";
    $replastring=$replastring."</a>";
    $replacement = array(
      0 => preg_replace("/aapnootMies/", $legawoord, $replastring),
      1 => preg_replace("/aapnootMies/", ucfirst($legawoord), $replastring),
      2 => preg_replace("/aapnootMies/", strtoupper($legawoord), $replastring),
    );
    
    ksort($pattern);
    ksort($replacement);
    $instr=preg_replace($pattern, $replacement, $instr, -1, $replcount);
    
   };
   return $instr;
 }
 
 function insert_text($ptr, $text){
   $this->reset();
   if($this->make_current_word($ptr)==""){
     $this->wordcount++;
     $this->wordsstored++;
     $this->wordpointer=$this->wordsstored;
     $this->words[$this->wordpointer]=$ptr;
   };
   $this->explanations[$this->wordpointer]=$text;
   
   $this->save();
 }
 
 function remove($ptr){
   if($this->make_current_word($ptr)!=""){
     unset($this->words[$this->wordpointer]);
     unset($this->explanations[$this->wordpointer]);
     ksort($this->words);
     ksort($this->explanations);
     $this->wordsstored--;
     $this->reset();
     $this->save();
   };
 
 }
 
 };
   function get_related_document_refs($pointerdoc, $collID){
     $task='/usr/lib/jvm/java-1.5.0-sun//bin/java -classpath /usr/lib/jvm/java-1.5.0-sun//jre/lib/rt.jar:/home/huygen/BEST/collexis/javalib/createcluster.jar:/home/huygen/BEST/collexis/javalib/collexisclasses.jar:/usr/share/java/activation.jar:/home/huygen/BEST/devroot/obj vu.cli.best.collexis.Search '.$pointerdoc.' '.$collID.'
            ';
     return parse_collexisdocrefs(monopipe($task));
   }
   
   function parse_collexisdocrefs($str){
     $coldoc=remove_javagarbage($str);
     if($coldoc=="") return array();
     try{
       $xml=new SimpleXMLElement(remove_javagarbage($coldoc));
     } catch (Exception $e){
       printf("<p>No good XML:<br>%s</p>\n", unhook($coldoc));
       printf("<p>without garbage:<br>%s</p>\n", unhook(remove_javagarbage($coldoc)));
     };
     for($i=0;$i<count($xml->recordlist->record);$i++){
       $ar[$i]= $xml->recordlist->record[$i][id];
     };
     return $ar;
   }
   
   function unhook($instr){
     $pat[0]="/\</";
     $rep[0]="&#60";
     $pat[1]="/\>/";
     $rep[1]="&#62";
     return preg_replace($pat, $rep, $instr) ;
   }
     function remove_javagarbage($string){
       $pattern='/<\?xml/';
       if(preg_match($pattern,$string)==0) return "";
       $pattern='/^.+<\?xml/';
       $replacement="<?xml"; return preg_replace($pattern,
       $replacement, $string); }
   
   
   function monopipe($task){
     $handle = popen($task, 'r');
     if(feof($handle)){
       $output=FALSE;
     } else {
       $output=trim(fread($handle, 2048));
     };
     while(!feof($handle)){
       $output=$output.fread($handle, 2048);
     };
     pclose($handle);
     return $output;
   }
   
   
   
 function concepttitle($conceptnum){
   if ($handle = fopen("/home/huygen/BEST/concepts/fp".$conceptnum, "rb")) {
     $rets=rtrim(fgets($handle));
     fclose($handle);
   } else {
     $rets="Concept ".$conceptnum." isternie";
   };
   return $rets;
 }
 class Conceptset {
     var $concepts=array();        // Array of Concepto objects. Counting starts at 1.
     var $active_concepts=array(); // Array with numbers of the active objects. Counting starts at 1.
     var $active_concept_count=0;
   
   
   function Conceptset(){
     parse_str($_SERVER['QUERY_STRING'], $params);
     $this->concepts=NULL;
     $this->active_concept_count=0;
     $this->active_concepts=array();
     $conceptseqnum=0;
     while(TRUE){
       $conceptseqnum++;
       $cnam="concept".$conceptseqnum;
       if($params[$cnam]=="") break;
       $this->concepts[$conceptseqnum]=new Concepto($params[$cnam]);
     };
     
     if($this->conceptcount()==0){
       if(parameter_value_of('mode')=="c"){
         $this->store_old_concepts();
       } else {
         if(parameter_value_of('mode')=="d"){
           $this->store_concepts_from_clusterlist(parameter_value_of('cl'));
         };
       };
     }
     
     
     $s=$params['concn'];
     if($s==""){
       $this->active_concept_count=0;
       $this->active_concepts=array();
     } else {
       $this->active_concepts=split(",", $s);
       $this->active_concept_count=count($this->active_concepts);
     };
     
   }
   
   function store_old_concepts(){
     for($i=1;$i<=36;$i++){
       $cid="fp".$i;
       $this->concepts[$i]=new Concepto($cid);
     };
   }
   
   function store_concepts_from_clusterlist($clusterfilnam){
     if($handle=fopen("/home/huygen/BEST/display/resources/casegroups/".$clusterfilnam, "rb")){
       $fpnums= explode(" ", trim(fgets($handle))); fclose($handle);
       if(count($fpnums)>0){
         $conceptcounter=0;
         foreach($fpnums as $key => $value){
          $concepttitle="fp".$value;
          $conceptcounter++;
          $this->concepts[$conceptcounter]= new Concepto($concepttitle);
         };
       };
     };
   }
   
   function make_empty(){
     unset($this->concepts);
     $this->active_concept_count=0;
     $this->active_concepts=array();
   }
   
   function concept($cnum){
     return $this->concepts[$cnum];
   }
   
   function first_concept(){
     return ( (reset($this->concepts)===FALSE)
            ? FALSE
            : current($this->concepts)
            );
     
   }
   
   function current_concept(){
     return ( (current($this->concepts)===FALSE)
            ? FALSE
            : current($this->concepts)
            );
     
   }
   
   function next_concept(){
     return ( (next($this->concepts)===FALSE)
            ? FALSE
            : current($this->concepts)
            );
     
   }
   
   function current_conceptkey(){
     return key($this->concepts);
   }
   
   function active_concept($num){
     if($this->active_concepts[$num]==""){
       return FALSE;
     } else {
       return $this->concepts[$this->active_concepts[$num]];
     };
   }
   
   function first_active_concept(){
     if(!(isset($this->active_concepts))) return FALSE;
     return ( (reset($this->active_concepts)===FALSE)
            ? FALSE
            : $this->concepts[current($this->active_concepts)]
            );
     
   }
   
   function current_active_concept(){
     if(!(isset($this->active_concepts))) return FALSE;
     return ( (current($this->active_concepts)===FALSE)
            ? FALSE
            : $this->concepts[current($this->active_concepts)]
            );
     
   }
   
   function next_active_concept(){
     if(!(isset($this->active_concepts))) return FALSE;
     return ( (next($this->active_concepts)===FALSE)
            ? FALSE
            : $this->concepts[current($this->active_concepts)]
            );
     
   }
   
   function current_active_conceptkey(){
     return current($this->active_concepts);
   }
   
   function first_nonactive_concept(){
     if(reset($this->concepts)===FALSE) return FALSE;
     // Multiple returns.
     while(TRUE){
       if(!in_array(key($this->concepts), $this->active_concepts)){
           return current($this->concepts);
       };
       if(next($this->concepts)===FALSE) return FALSE;
     };
     return FALSE;
   }
   function current_nonactive_concept(){
     return current($this->concepts);
   
   }
   function next_nonactive_concept(){
     if(next($this->concepts)===FALSE) return FALSE;
     // Multiple returns.
     while(TRUE){
       if(!in_array(key($this->concepts), $this->active_concepts)){
         return current($this->concepts);
       };
       if(next($this->concepts)===FALSE) return FALSE;
     };
     return FALSE;
   
   }
   function conceptcount(){
     return count($this->concepts);
   }
   
   function active_concept_count(){
     return count($this->active_concepts);
   }
   
   function arra(){
     if($this->active_concept_count==0) return NULL;
     return $this->active_concepts;
   }
   function querystring_with_conceptnr($connum, $dispmode){
     if(($this->active_concept_count==0) || $dispmode=="c"){
      $ar= array($connum);
     } else {
     $ar=$this->active_concepts;
     insert_value_into_array($ar, $connum);
     sort($ar);
     };
     return modified_querystring("concn", implode(",",$ar));
   }
   
   function querystring_without_conceptnr($connum){
     if($this->active_concept_count==0){
     return modified_querystring("concn", "");
     };
     $ar=$this->active_concepts;
     remove_value_from_array($ar, $connum);
     sort($ar);
     return modified_querystring("concn", implode(",",$ar));
   }
   
   function is_active_concept($n){
     if($this->active_concept_count==0) return FALSE;
     $res=FALSE;
     foreach($this->active_concepts as $cn){
       if($cn==$n){
         $res=TRUE;
         break;
       };
     };
     return $res;
   }
   
   function concept_seqnum($n){
     if($this->active_concept_count==0) return FALSE;
     sort($this->active_concepts);
     $res=0;
     $i=0;
     foreach($this->active_concepts as $cn){
       $i++;
       if($cn==$n){
         $res=$i;
         break;
       };
     };
     return $res;
   }
   function querystring_with_conceptlist(){
     $quest=$_SERVER['QUERY_STRING'];
     foreach($this->concepts as $num => $con){
       $par="concept".$num;
       $val=$con->uri();
       $quest=cascmodified_querystring($quest, $par, $val);
     };
     return $quest;
   }
   
   
 }
 
 function insert_value_into_array( &$ar, $val){
   if(isset($ar)){
     foreach($ar as $key => $v){
       if($v==$val) unset($ar[$key]);
     };
   };
   $ar[]=$val;
   return;
 }
 
 function remove_value_from_array( &$ar, $val){
   foreach($ar as $key => $v){
     if($v==$val) unset($ar[$key]);
   };
   return;
 }
 
 function is_in_range($lower, $para, $upper){
   return (  ($lower<=$para)  &&  ($para<=$upper ) );
 }
 
?>
