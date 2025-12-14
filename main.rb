require_relative 'lib/hashmap'

hash_map = HashMap.new


hash_map.set('apple', 'red')
hash_map.set('banana', 'yellow')
hash_map.set('carrot', 'orange')
hash_map.set('dog', 'brown')
hash_map.set('elephant', 'gray')
hash_map.set('frog', 'green')
hash_map.set('lion', 'golden')
hash_map.set('grape', 'purple')
hash_map.set('hat', 'black')
hash_map.set('ice cream', 'white')
hash_map.set('jacket', 'blue')
hash_map.set('kite', 'pink')
hash_map.set('kitty', 'pink')

p hash_map
p hash_map.grow