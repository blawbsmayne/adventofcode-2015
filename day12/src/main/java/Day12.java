import org.json.JSONArray;
import org.json.JSONObject;

import java.util.Iterator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by blawbsmayne on 12.12.15.
 * Possible Solution for Day12 of adventofcode.com
 */
public class Day12 {

    public static void main(String[] args){
        //solve part one with basic regex
        int result1 = 0;
        Pattern p = Pattern.compile("-?\\d+");
        Matcher m = p.matcher(Input.input);
        while (m.find()) {
            result1 += Integer.decode(m.group());
        }
        System.out.println("Part One: "+result1);

        //solve part two recursively
        JSONArray json = new JSONArray(Input.input);
        int result2 = handleArray(json);
        System.out.println("Part Two: "+result2);
    }

    private static int handleArray(JSONArray arr){
        int arrCount = 0;
        for (int i = 0; i < arr.length(); i++){
            Object o = arr.get(i);
            if(o instanceof JSONArray) {
                arrCount += handleArray((JSONArray) o);
            }
            else if(o instanceof JSONObject){
                arrCount += handleObject((JSONObject) o);
            }
            else if(o instanceof Integer){
                arrCount += (Integer)o;
            }
            else{
                //ignore Strings in arrays
            }
        }
        return arrCount;
    }

    private static int handleObject(JSONObject o) {
        int objectCount = 0;
        Iterator it = o.keys();
        while(it.hasNext()){
            Object n = it.next();
            Object content = o.get(n.toString());
            if(content instanceof JSONObject){
                objectCount += handleObject((JSONObject) content);
            }
            else if(content instanceof String){
                if (content.equals("red")){
                    return 0; //JSONObject can be ignored
                }
            }
            else if(content instanceof JSONArray){
                objectCount += handleArray((JSONArray) content);
            }
            else if (content instanceof Integer){
                objectCount += (Integer)content;
            }
        }
        return objectCount;
    }
}
