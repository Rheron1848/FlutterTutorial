// 05_classes.dart
// Dart 面向对象 — 与 Python 类概念相似，语法不同

void main() {
  // === 1. 基本类 ===
  var animal = Animal('旺财', 3);
  animal.speak(); // 旺财 says: ...
  print(animal); // Animal(name: 旺财, age: 3)

  // === 2. 命名构造函数 ===
  var baby = Animal.baby('小猫');
  print(baby); // Animal(name: 小猫, age: 0)

  // === 3. 继承 ===
  var dog = Dog('旺财', 3, '金毛');
  dog.speak(); // 旺财 barks: 汪汪!
  dog.fetch(); // 旺财 is fetching...

  var cat = Cat('咪咪', 2);
  cat.speak(); // 咪咪 meows: 喵喵~

  // === 4. Mixin（Dart 特有的多继承替代）===
  var duck = Duck('唐老鸭');
  duck.swim(); // 唐老鸭 is swimming
  duck.fly(); // 唐老鸭 is flying
  duck.speak(); // 唐老鸭 quacks: 呱呱
}

// --- 基类 ---
class Animal {
  String name;
  int age;

  // 默认构造函数
  Animal(this.name, this.age);

  // 命名构造函数
  Animal.baby(this.name) : age = 0;

  void speak() {
    print('$name says: ...');
  }

  @override
  String toString() => 'Animal(name: $name, age: $age)';
}

// --- 继承 ---
class Dog extends Animal {
  String breed;

  // 调用父类构造函数
  Dog(String name, int age, this.breed) : super(name, age);

  @override
  void speak() {
    print('$name barks: 汪汪!');
  }

  void fetch() {
    print('$name is fetching...');
  }
}

class Cat extends Animal {
  Cat(String name, int age) : super(name, age);

  @override
  void speak() {
    print('$name meows: 喵喵~');
  }
}

// --- Mixin（类似多继承，但更安全）---
mixin Swimmer {
  void swim() {
    print('$this is swimming');
  }
}

mixin Flyer {
  void fly() {
    print('$this is flying');
  }
}

class Duck extends Animal with Swimmer, Flyer {
  Duck(String name) : super(name, 0);

  @override
  void speak() {
    print('$name quacks: 呱呱');
  }
}
