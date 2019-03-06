public class Cat implements Comparable<Cat> {
    @Override
    public String toString() {
        return "Cat{" +
                "name='" + name + '\'' +
                ", age=" + age +
                '}';
    }

    Cat(String name, int age) {
        this.name = name;
        this.age = age;
    }

    private String name;

    int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    private int age;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public int compareTo(Cat o) {
        return this.age - o.age;
    }
}
