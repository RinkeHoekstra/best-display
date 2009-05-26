package vu.cli.best.collexis;
import org.tempuri.collexissoapclient5.wsdl.CServerMatchSoapPort;
import org.tempuri.collexissoapclient5.wsdl.CollexisSoapClient5Locator;
import java.io.IOException; 
import java.io.StringReader;
import javax.xml.parsers.FactoryConfigurationError;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import org.xml.sax.*;

/**
 * @author mcaklein
 *
 */
public class Search {

  public static void main(String[] args) {
    String result;
      int argtal=args.length;
      String fp="m4_defaultfingerprint";
      String collID = "1770783843";
      String lastarg="";
      if(argtal==1){
        fp = args[0];
      } else {
        if(argtal>1){
          fp="";
          lastarg=args[0];
          for(int i=1;i<argtal;i++){
            if(fp==""){
              fp=lastarg;
            } else {
              fp=fp+" "+lastarg;
            }
            lastarg=args[i];
          };
          collID = lastarg;
        };
      };
      
    try {
      CollexisSoapClient5Locator collexis = new CollexisSoapClient5Locator();
      CServerMatchSoapPort mySOAPport = collexis.getCServerMatchSoapPort();
      result = 
        mySOAPport.getSimilar
        ( collID
        , "<collexion name='"+collID+"'><record id='"+fp+"'/></collexion>"
        , "collexis",100,0.05f,0,"","*",200,10,0.3f,0f,0,0.4f,"","",0,0,0
        );
      
         System.out.println(result);
      
    }   
    catch (FactoryConfigurationError e){
       System.out.println("<error>");
       System.out.println(" <errortyp>");
       System.out.println("   FactoryConfigurationError");
       System.out.println(" </errortyp>");
       System.out.println(" <errortext>");
       System.out.println("   cannot get document builder factory");
       System.out.println(" </errortext>");
       System.out.println("</error>");
    }
    
    catch (IOException e){
       System.out.println("<error>");
       System.out.println(" <errortyp>");
       System.out.println("   IOException");
       System.out.println(" </errortyp>");
       System.out.println(" <errortext>");
       System.out.println("   i/o exception");
       System.out.println(" </errortext>");
       System.out.println("</error>");
    }
    
    catch (Exception e){
       System.out.println("<error>");
       System.out.println(" <errortyp>");
       System.out.println("   Exception");
       System.out.println(" </errortyp>");
       System.out.println(" <errortext>");
       System.out.println("   don't know");
       System.out.println(" </errortext>");
       System.out.println("</error>");
    }
    
  };
}

