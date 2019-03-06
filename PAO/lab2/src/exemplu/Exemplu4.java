public class Exemplu4 {
    public static void main(String[] args) {
        int[][] m = new int[4][];
        m[0] = new int[3];
        for (int[] x :
                m) {
            System.out.println(x);
        }
    }
}
