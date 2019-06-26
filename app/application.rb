require 'pry'
class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/) #two possibilities -- path includes 'items' or it doesn't (doesn't -> else 404 status)
      item = req.path.split("/items/").last
      # if @@items.names.include?()
      if @@items.map{|object| object.name}.include?(item)
        item_price = @@items.find {|i| i.name == item}.price
        resp.write item_price
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end
end