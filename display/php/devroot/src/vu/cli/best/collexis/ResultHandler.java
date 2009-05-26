/**
 * 
 */
package vu.cli.best.collexis;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;
import java.lang.String;
import java.util.*;

/**
 * @author mcaklein
 *
 */
public class ResultHandler extends DefaultHandler {

  protected String zaaknummers = "";
  protected String datum = "";
  protected String instantie = "";
  protected String ljn = "";
  private String fp;
    protected String count = "";
    private final String READ = "READ";
    
    private Vector clusterElements = new Vector();
  
  public ResultHandler(String fp) {
     super();
     this.fp = fp;
  }
  
  @Override
  public void startDocument() throws SAXException {
     // TODO Auto-generated method stub
     System.out.println("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><ClassificationTree version=\"1.0\"><ObjectSet>");
  }
  
  @Override
  public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
     // TODO Auto-generated method stub
     if (localName.equals("record")) {
        datum = "";
        instantie = "";
        zaaknummers = "";
        ljn = attributes.getValue("id");
        clusterElements.add(ljn);
        System.out.println("<Object ID=\""+ljn+"\">");
        System.out.println("<Location>http://www.rechtspraak.nl/ljn.asp?ljn="+ljn+"</Location>");
     } else if (localName.equals("datum")) {
        datum = READ;
     } else if (localName.equals("instantie")) {
        instantie = READ;
     } else if (localName.equals("zaaknummers")) {
        zaaknummers = READ;
     } else if (localName.equals("count")) {
        count = READ;
     } 
  }
  
  
  @Override
  public void endElement(String uri, String localName, String qName) throws SAXException {
     // TODO Auto-generated method stub
     if (localName.equals("record")) {
        System.out.println("<Name>"+instantie+" "+datum+", "+zaaknummers+"</Name>");
        System.out.println("</Object>");
     } else if (localName.equals("count")) {
        System.out.println("<!-- "+count+" object found -->");
     }
  }
  
  
  @Override
  public void characters(char[] ch, int start, int length) throws SAXException {
     // TODO Auto-generated method stub
     if (datum.equals(READ)) {
        datum = new String(ch, start, length);
     }
     if (instantie.equals(READ)) {
        instantie = new String(ch, start, length);
     }
     if (zaaknummers.equals(READ)) {
        zaaknummers = new String(ch, start, length);
     }
     if (count.equals(READ)) {
        count = new String(ch, start, length);
     }
  }
  
  
  @Override
  public void endDocument() throws SAXException {
     // TODO Auto-generated method stub
     System.out.println("</ObjectSet><ClassificationSet>");
     System.out.println("<Classification ID=\""+fp+"\">");
     System.out.println("<Name>"+fp+"</Name>");
     System.out.print("<Objects objectIDs=\"");
     Iterator it = clusterElements.iterator ();
     while (it.hasNext ()) {
        ljn = (String)it.next ();
        System.out.print(ljn+" ");
     } 
     System.out.println("\"/></Classification>");
     System.out.println("</ClassificationSet></ClassificationTree>");
  }
  
}

