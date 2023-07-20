void main() {
  final regex = RegExp(r'^[A-Za-z]+(\s[A-Za-z0-9]+)*$');

  const inputs = [
    'course',
    '12course',
    'course12',
    'cursos 12 hola hola 1',
    '',
    '    ',
    'Course',
    'course 1',
    'Course 1',
    'Course I',
    '*/',
    '-'
  ];

  for (final input in inputs) {
    print('Does "$input" matches? ${regex.hasMatch(input)}');
  }
}
