console.log("hello world");

let map = new Map();

map.set("abc", "cde");
console.log(map.get("abc"));
console.log(map.size);

class Student {
  private firstName: String;
  private lastName: String;
  private teacherName: String;

  constructor(firstName?: string, lastName?: string, teacherName?: string) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.teacherName = teacherName;
  }

  getGrades() {
    console.log("hello world");
  }
}
