class KoalaFake
  User = Struct.new(:name, :id)
  USERS = [
    { "name" => "Elizabeth Alabdfbjgafef Huisky", "id" => "113593735732695" },
    { "name" => "Carol Alabebdiafcja Smithberg", "id" => "105338816560282" },
    { "name" => "Charlie Alabeicdfjfdi Smithson", "id" => "100610493702066" }
  ]

  MUTUALFRIENDS =
    { "context" =>
      { "mutual_friends" =>
        { "data" =>
          [{ "name" => "Carol Alabebdiafcja Smithberg", "id" => "105338816560282" },
          { "name" => "Charlie Alabeicdfjfdi Smithson", "id"=>"100610493702066" }],
         "paging" => { "cursors" => { "before" => "MTEzNTkzNzM1NzMyNjk1", "after" => "MTEzNTkzNzM1NzMyNjk1" } },
         "summary" => { "total_count" => 1 } },
       "mutual_likes" => { "data" => [], "summary" => { "total_count" => 0 } },
       "id" => "dXNlcl9jb250ZAXh0OgGQDepANcR5qySRUOeivSUWTV6nSSCOPXjBLRt09rEE5zuudygAO4GTPQ8n0BuzmMAZB660pGu3YiS29a3HStXNF1lkNosDbHry57LepVH4jqrQZD" },
     "id" => "100610493702066" }

  def initialize(token, secret)
  #   # binding.pry
  end

  def get_connections(arg1, arg2)
    USERS.map(&:to_h)
  end

  def get_object(arg1, arg2)
    MUTUALFRIENDS
  end
end
