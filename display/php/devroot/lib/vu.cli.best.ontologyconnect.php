<?php
  require_once "HTTP/Request.php";
  class Ontologyconnect{
      var $host="http://appia.rechten.vu.nl";
      var $port="8180";
      var $ontoname="best";
      var $repositoriesdir="openrdf-sesame/repositories";
      var $repo_url;
    var $ns_best="http://www.best-project.nl/2008/04/layman#";
    var $ns_owl="http://www.w3.org/2002/07/owl#";
    var $ns_rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#";
    var $ns_rdfs="http://www.w3.org/2000/01/rdf-schema#";
    var $ns_xsd="http://www.w3.org/2001/XMLSchema#";
    public $rdfs_subclass;
    public $rdfs_comment;
    public $best_preflabel;
    
    function __construct(){
      $this->repo_url=$this->host.":".$this->port."/".$this->repositoriesdir."/".$this->ontoname;
      $this->rdfs_subclass=$this->curi($this->ns_rdfs, "subClassOf");
      $this->rdfs_comment=$this->curi($this->ns_rdfs, "comment");
      $this->best_preflabel=$this->curi($this->ns_best, "prefLabel");
      
    }
    
    function curi($ns,$id){
      return "<".$ns.$id.">";
    }
    function unhook_uri($uri){
      $pat[0]="/\</";
      $rep[0]="&#60";
      $pat[1]="/\>/";
      $rep[1]="&#62";
      return preg_replace($pat, $rep, $uri) ;
    }
    
    function selectquery($query){
      $questar=array('query'=>$query, 'queryLn'=>"sparql");
      $extendedurl=$this->repo_url."?".http_build_query($questar);
      $req=& new HTTP_Request($extendedurl);
      $req->addHeader('Accept', 'application/sparql-results+xml, */*;q=0.5');
      if (PEAR::isError($req->sendRequest())) {
        return FALSE;
      } else {
        return $req->getResponseBody();
      };
    }
    
    function get_single_element_from_queryxmlresult($qresult, $type){
      if($qresult===FALSE){
        return FALSE;
      } else {
        $xml=new SimpleXMLElement($qresult);
        if($type=="literal") return $xml->results[0]->result[0]->binding[0]->literal[0];
        
        if($type=="uri") return $xml->results[0]->result[0]->binding[0]->uri[0];
        
      };
    }
    
    function get_object_elements($subject, $predicate, $type){
      $query="select ?x where { ".$subject." ".$predicate." ?x }";
      $response= $this->selectquery($query);
      if($response===FALSE) return FALSE;
      $xml=new SimpleXMLElement($response);
      if($type=="literal") return $xml->results[0]->result[0]->binding[0]->literal;
      
      if($type=="uri") return $xml->results[0]->result[0]->binding[0]->uri;
      
    }
    
    
  
  }
  
  
?>
