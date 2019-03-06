public class Exemplu1 {
    public static void main(String[] args) {
        int []x;
        x = new int[10];
        x[0]=10;
        x[1]=20;
        x[5]=40;
        for (int i = 0; i < x.length; i++) {
            System.out.print(x[i]);
        }
    }
}
