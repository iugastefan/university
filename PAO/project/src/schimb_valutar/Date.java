package schimb_valutar;

public class Date implements Comparable<Date> {
    private int zi;
    private int luna;
    private int an;

    public Date(int zi, int luna, int an) {
        this.zi = zi;
        this.luna = luna;
        this.an = an;
    }

    public int getZi() {
        return zi;
    }

    public int getLuna() {
        return luna;
    }

    public int getAn() {
        return an;
    }

    public int compareTo(Date other) {
        int anDiff = this.an - other.an;
        int lunaDiff = this.luna - other.luna;
        int ziDiff = this.zi - other.zi;
        if (anDiff != 0)
            return anDiff;
        else if (lunaDiff != 0)
            return lunaDiff;
        return ziDiff;
    }

    public boolean equals(Date other) {
        return this.an == other.an && this.luna == other.luna && this.zi == other.zi;
    }

    @Override
    public String toString() {
        return this.zi + "." + this.luna + "." + this.an;
    }
}
