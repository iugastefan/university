package schimb_valutar;

class Casier extends Persoana {
    // TODO: de luat din DB ultimul id folosit
    static private int nextId = 1;
    private int id;

    Casier(String nume, String prenume) {
        this.nume = nume;
        this.prenume = prenume;
        this.id = nextId++;
    }

    @Override
    public String toString() {
        return "Id: " + id + "\t Nume: " + nume + " Prenume: " + prenume;
    }
}
