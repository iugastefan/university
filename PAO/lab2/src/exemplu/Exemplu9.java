import java.util.Arrays;

public class Exemplu9 {
    public static void main(String[] args) {
        int[]x={3,7,2,6,8,9,0,3};
        Arrays.sort(x);
        for (int x1 : x) {
            System.out.print(x1 + " ");
        }
        int i= Arrays.binarySearch(x,2);
        System.out.println(i);
    }

}
