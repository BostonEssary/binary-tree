require_relative 'tree'

arr = [1, 2, 3, 4, 5, 6, 7]

tree = Tree.new(arr)
p arr.uniq.sort
p tree.inorder.length