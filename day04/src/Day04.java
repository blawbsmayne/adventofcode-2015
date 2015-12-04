import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Created by me on 04.12.15.
 */
public class Day04 {

    public static void main(String[] args){
        long time = System.currentTimeMillis();
        String secret = "yzbqklnj";
        int count = 0;
        boolean foundPt1 = false;
        boolean foundPt2 = false;
        while(true){
            String test = secret+count;
            test = md5(test);
            if(test.substring(0,5).equalsIgnoreCase("00000") && !foundPt1){
                System.out.println("The correct number (Part 1) is "+count);
                System.out.println("Found answer in "+(System.currentTimeMillis()-time)+" ms.");
                foundPt1 = true;
            }
            if(test.substring(0,6).equalsIgnoreCase("000000") && !foundPt2){
                System.out.println("The correct number (Part 2) is "+count);
                System.out.println("Found answer in "+(System.currentTimeMillis()-time)+" ms.");
                foundPt2 = true;
            }
            if (foundPt1 && foundPt2) break;
            count++;
        }
    }

    public static String md5(String in){
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] b = md.digest(in.getBytes());
            String result = "";
            for (int i=0; i < b.length; i++) {
                result += Integer.toString( ( b[i] & 0xff ) + 0x100, 16).substring( 1 );
            }
            return result;
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return "";
        }
    }
}
