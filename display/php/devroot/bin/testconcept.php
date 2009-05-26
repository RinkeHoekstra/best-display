#!/usr/bin/php -f
<?php
$con=new Concept();
$con->input_title("Title of the concept");
$con->input_id(1);
$con->put_some_fingerprintstrings_in_it();
$con->match("In deze zin staat aap noot mies scha-pen.");
$mat=$con->matchafter(0);
if($mat!=""){
  printf("Match begint op %d en is %d letters lang.\n", $mat->offset(), $mat->length());
}
function get_related_document_refs($pointerdoc){
  $task='/usr/lib/jvm/java-1.5.0-sun//bin/java -classpath /usr/lib/jvm/java-1.5.0-sun//jre/lib/rt.jar:/home/huygen/BEST/collexis/javalib/createcluster.jar:/home/huygen/BEST/collexis/javalib/collexisclasses.jar:/usr/share/java/activation.jar:/home/huygen/BEST/devroot/obj vu.cli.best.collexis.Search '.$pointerdoc.'
         ';
  return parse_collexisdocrefs(monopipe($task));

}

function parse_collexisdocrefs($coldoc){
  $xml=new SimpleXMLElement(remove_javagarbage($coldoc));
  for($i=0;$i<count($xml->recordlist->record);$i++){
    $ar[$i]= $xml->recordlist->record[$i][id];
  };
  return $ar;
}

function remove_javagarbage($string){
  $pattern='/^.+<\?xml/';
  $replacement="<?xml";
  return preg_replace($pattern, $replacement, $string);
}


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


function parameter_value_of($parnam){
  parse_str($_SERVER['QUERY_STRING'], $params);
  return $params[$parnam];
}

function modified_querystring($parnam, $parval){
  parse_str($_SERVER['QUERY_STRING'], $params);
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
class Concept{
    var $title = "";
    var $id = 0;
  var $fingerphrases;
  var $fingerweights;
  var $fingercount = 0;
  var $matchstring = "";
  var $matchcount = 0;
  var $matchoff;
  var $matchlen;
  var $matchfingnum;
  var $singlewordmatchcount = 0;
  var $multiwordmatchcount = 0;
  var $matchweightssum = 0;
  

  function __construct(){
   
  }

  function input_title($title){
    $this->title=$title;
  }
  
  function input_id($id){
    $this->id=$id;
  }
  
  function title(){
   return $this->title;
  }
  
  
  function id(){
   return $this->id;
  }
  
  function init_with_fingerprint_file($conceptnum){
    $this->id=$conceptnum;
    if ($handle = fopen("/home/huygen/BEST/concepts/fp".$conceptnum, "rb")) {
      $title=rtrim(fgets($handle));
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
      $rets="Concept ".$conceptnum." isternie";
    };
    
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
  
  function matchafter($offset){
    $matchid=1;
    while( ($matchid<$this->matchcount) 
             && 
           ($this->matchoff[$matchid]<=$offset)
         ) $matchid++;
    if($this->matchoff[$matchid]>$offset){
      return new Matchingstring
                 ( $this->matchoff[$matchid]
                 , $this->matchlen[$matchid]
                 , $this->id
                 , $this->fingerweights[$this->matchfingnum[$matchid]]
                 , count(explode(" ", $this->fingerphrases[$this->matchfingnum[$matchid]]))
                 );
    } else {
      return "";
    };
  }
  
  function put_some_fingerprintstrings_in_it(){
     $this->fingerphrases[1]="aap noot mies";
     $this->fingerphrases[2]="scha-pen";
     $this->fingerphrases[3]="mies";
     $this->fingerweights[1]="80";
     $this->fingerweights[2]="40";
     $this->fingerweights[3]="20";
     $this->fingercount=3;
  }
  
}
class Conceptset {
  var $active_concepts;
  var $active_concept_count=0;
  
  function Conceptset(){
    parse_str($_SERVER['QUERY_STRING'], $params);
    $s=$params['concn'];
    if($s==""){
      $this->active_concept_count=0;
      $this->active_concepts=NULL;
    } else {
      $this->active_concepts=split(",", $s);
      $this->active_concept_count=count($this->active_concepts);
    };
  }
  function make_empty(){
    $this->active_concept_count=0;
    $this->active_concepts=NULL;
  }
    function nr(){
      return $this->active_concept_count;
    }
  function arra(){
    if($this->active_concept_count==0) return NULL;
    return $this->active_concepts;
  }
  function querystring_with_conceptnr($connum){
    if($this->active_concept_count==0){
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
class Matchingstring {
 var $offs;
 var $len;
 var $cn;
 var $wt;
 var $nrwords;
   function Matchingstring( $of, $ln, $connum, $wet, $wot){
     $this->offs=$of;
     $this->len=$ln;
     $this->cn=$connum;
     $this->wt=$wet;
     $this->nrwords=$wot;
   }
 function connum(){
   return $this->cn;
 }
 
 function wc(){
   return $this->nrwords;
 }
 
 function offset(){
   return $this->offs;
 }
 
 function length(){
   return $this->len;
 }
 
 function weight(){
   return $this->wt;
 }
 
 function matches_par($paroff, $parlen){
   return (is_in_range($paroff, $this->offs, $paroff+$parlen));
 }
 
}
function concepttagclass($relevantconcepts){
  global $conceptset;
  $conceptcount=0;
  $taglabel="p";
  sort($relevantconcepts);
  for($i=1;$i<=36;$i++){
    if(in_array($i,$relevantconcepts)){
      $conceptcount++;
      $taglabel=$taglabel.telwoordvan($conceptset->concept_seqnum($i));
      if($conceptcount>=3) break;
    };
  };
  return $taglabel;
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
function nextphrase($bp, &$pmatchar, &$offset, &$len, &$classname){
  global $conceptset;
  $offset=0;
  $len=0;
  $weight=0;
  $foundone=FALSE;
  if(isset($pmatchar)){
    foreach($pmatchar as $i => $mat){
      if($mat->offset()<$bp){
        unset($pmatchar[$i]);
        continue;
      };
      if(  ($mat->offset()<$offset)
                  || 
          ($offset==0)
                  ||
         ( ($mat->offset()==$offset) && ($mat->weight>$weight) )
        ){
        $foundone=TRUE;
        $offset=$mat->offset();
        $len=$mat->length();
        $weight=$mat->weight();
        $classname="f".telwoordvan($conceptset->concept_seqnum($mat->connum()));
        unset($pmatchar[$i]);
      }
    };
  };
  return $foundone;
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
