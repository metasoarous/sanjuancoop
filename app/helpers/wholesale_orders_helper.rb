module WholesaleOrdersHelper
  def ordering_instructions
    string = "<p>To place a new order visit either "
    array = Distributor.all.map {|dis| "<a href=#{dis.website}>#{dis.name}</a>"}
    string += array.join(" or ")
    string += ", place your order there under the coop account and then return here to enter in your order information so that we can better keep track of your orders.</p>"
  end
end
