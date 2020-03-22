class Student
  attr_reader(:id, :name, :grade)
  
  def initialize(name, grade, id = nil)
    @id = id
    @name = name
    @grade = grade
  end
  
  def self.create_table()
    DB[:conn].execute("CREATE TABLE students (id INTEGER PRIMARY KEY, name TEXT, grade INTEGER);")
  end
  
  def self.drop_table()
    DB[:conn].execute("DROP TABLE students;")
  end
  
  def self.create(attributes)
    new_student = Student.new(attributes[:name], attributes[:grade])
    new_student.save()
    return new_student
  end
  
  def save()
    sql = "INSERT INTO students (name, grade) VALUES (?,?);"
    DB[:conn].execute(sql, @name, @grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end
end
