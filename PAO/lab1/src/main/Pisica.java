package main;


class Pisica {
    String nume;
    String culoare;

    Pisica(String nume, String culoare) {
        this.nume = nume;
        this.culoare = culoare;
    }

    Pisica() {
    }

    void Afis() {
        if (nume != null || culoare != null) System.out.println(nume + " de culoare " + culoare);
        System.out.println("Initializeaza parametrii!");
    }
}
