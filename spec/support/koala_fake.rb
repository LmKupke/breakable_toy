class KoalaFake
  User = Struct.new(:name, :id)
  USERS = [
    {"name"=>"Elizabeth Alabdfbjgafef Huisky", "id"=>"113593735732695"},
    {"name"=>"Carol Alabebdiafcja Smithberg", "id"=>"105338816560282"},
    {"name"=>"Charlie Alabeicdfjfdi Smithson", "id"=>"100610493702066"}
  ]

  def initialize(token, secret)
  #   # binding.pry
  end
  #
  def get_connections(arg1, arg2)
    USERS.map(&:to_h)
  end
end
