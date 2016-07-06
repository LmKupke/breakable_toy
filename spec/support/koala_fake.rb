class KoalaFake
  User = Struct.new(:name, :id)
  USERS = [
    User.new("Elizabeth Alabdfbjgafef Huisky", "113593735732695"),
    User.new("Carol Alabebdiafcja Smithberg", "105338816560282"),
    User.new("Charlie Alabeicdfjfdi Smithson", "100610493702066")
  ]

  def initialize(token, secret)
  #   # binding.pry
  end
  #
  def get_connections(arg1, arg2)
    USERS.map(&:to_h)
  end
end
