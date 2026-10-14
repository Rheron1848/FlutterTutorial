// 04_collections.dart
// Dart 集合 — List/Set/Map 对应 Python 的 list/set/dict

void main() {
  // === 1. List（类似 Python list）===
  // Python: nums = [1, 2, 3]
  List<int> nums = [1, 2, 3, 4, 5];
  print('nums: $nums');
  print('first: ${nums.first}, last: ${nums.last}');
  print('length: ${nums.length}');

  // 添加/删除
  nums.add(6);
  nums.remove(1);
  print('after add/remove: $nums');

  // 常用方法（类似 Python 的同名函数）
  // Python: [n*2 for n in nums] 或 list(map(lambda n: n*2, nums))
  var doubled = nums.map((n) => n * 2).toList();
  print('map doubled: $doubled');

  // Python: [n for n in nums if n > 3] 或 list(filter(lambda n: n>3, nums))
  var filtered = nums.where((n) => n > 3).toList();
  print('where > 3: $filtered');

  // 展开操作符（Python 的 *list 解包）
  var more = [0, ...nums, 7, 8];
  print('spread: $more');

  // === 2. Set（类似 Python set）===
  Set<String> tags = {'flutter', 'dart', 'mobile'};
  tags.add('flutter'); // 重复不会添加
  tags.add('coding');
  print('tags: $tags');
  print('has flutter: ${tags.contains('flutter')}');

  // === 3. Map（类似 Python dict）===
  // Python: user = {"name": "Alice", "age": 25}
  Map<String, dynamic> user = {
    'name': 'Alice',
    'age': 25,
    'isAdmin': true,
  };
  print('user: $user');
  print('name: ${user['name']}');

  // 遍历
  user.forEach((key, value) {
    print('$key => $value');
  });

  // === 4. List 的集合操作 ===
  var list1 = [1, 2, 3, 4];
  var list2 = [3, 4, 5, 6];

  // 两个列表的交集
  // Python: [n for n in list1 if n in list2]
  var common = list1.where((n) => list2.contains(n)).toList();
  print('common: $common'); // [3, 4]

  // 筛选满足条件的第一个元素
  var firstEven = list1.firstWhere((n) => n % 2 == 0);
  print('first even: $firstEven');

  // 检查是否所有/任一满足条件
  // Python: all(n > 0 for n in list1)  /  any(n > 3 for n in list1)
  print('all > 0: ${list1.every((n) => n > 0)}');
  print('any > 3: ${list1.any((n) => n > 3)}');

  // 排序
  var unsorted = [3, 1, 4, 1, 5, 9];
  unsorted.sort();
  print('sorted: $unsorted');
}
