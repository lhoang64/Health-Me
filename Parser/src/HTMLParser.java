/**
 * Created by Linh on 5/9/16.
 */

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import java.io.File;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class HTMLParser {
    public static void main(String[] args){
        List<String> symptoms = new ArrayList<String>();
        symptoms.add("Cough");
        symptoms.add("Fever");
        symptoms.add("Nausea");
        symptoms.add("Headache");

        try {
            for (String symptom : symptoms) {
                String url = "http://www.homeremediesforyou.com/" + symptom;
                Document doc = Jsoup.connect(url).get();
                File file = new File("/Users/Linh/IdeaProjects/Parser/" + symptom + ".txt");
                Elements remedies = doc.select("b");

                if (!file.exists()) {
                    file.createNewFile();
                }

                FileWriter writer = new FileWriter(file.getAbsoluteFile());
                BufferedWriter bufWriter = new BufferedWriter(writer);
                for (Element remedy : remedies) {
                    bufWriter.write(remedy.text() + "\n");
                }
                bufWriter.close();
                }
            //}
        } catch(IOException e){
                e.printStackTrace();
        }
    }
}
