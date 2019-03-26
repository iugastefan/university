package schimb_valutar;

class Client extends Persoana {
    private long cnp;
    private String serie_id;
    private int numar_id;

    public Client(String nume, String prenume, long cnp, String serie_id, int numar_id) {
        this.nume = nume;
        this.prenume = prenume;
        this.cnp = cnp;
        this.serie_id = serie_id;
        this.numar_id = numar_id;
    }

    public long getCnp() {
        return cnp;
    }

    public void setCnp(long cnp) {
        this.cnp = cnp;
    }

    public String getSerie_id() {
        return serie_id;
    }

    public void setSerie_id(String serie_id) {
        this.serie_id = serie_id;
    }

    public int getNumar_id() {
        return numar_id;
    }

    public void setNumar_id(int numar_id) {
        this.numar_id = numar_id;
    }
}
