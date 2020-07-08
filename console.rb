require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

require('pry-byebug')

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()


customer1 = Customer.new({
    'name' => 'John',
    'funds' => 20
})

customer1.save()

film1 = Film.new({
    'title' => 'The GodFather',
    'price' => 15
})

film1.save()

film2 = Film.new({
    'title' => 'Alien',
    'price' => 15
})

film2.save()

film3 = Film.new({
    'title' => 'Jaws',
    'price' => 15
})

film3.save()

ticket1 = Ticket.new({
    'customer_id' => customer1.id,
    'film_id' => film1.id
})

ticket1.save()


binding.pry
nil