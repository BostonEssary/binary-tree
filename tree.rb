require_relative "node"

class Tree

    attr_accessor :root

    def initialize(arr)
        @root = build_tree(arr.uniq.sort)
    end

    def build_tree(arr)
        return nil if arr.empty?
        
        mid = (arr.length-1)/2
        node = Node.new(arr[mid])
        


        node.left_child = build_tree(arr[0...mid])
        node.right_child = build_tree(arr[(mid+1)..(arr.length - 1)])
        
        
        return node
    end

    def insert(current_node = @root , value)
        if current_node.nil?
            return 
        end

        if current_node.value < value
            if current_node.right_child.nil?
                current_node.right_child = Node.new(value)
            else
                current_node.right_child = insert(current_node.right_child, value)
            end
        else
            if current_node.left_child.nil?
                current_node.left_child = Node.new(value)
            else
                current_node.left_child = insert(current_node.left_child, value)
            end
        end
    end

    def find(current_node = @root, value)
        if current_node.nil?
            return
        end

        if value == current_node.value
            return current_node
        elsif value > current_node.value
            find(current_node = current_node.right_child, value)
        else
            find(current_node = current_node.left_child, value)
        end
    end

    def delete(current_node = @root, value)
        if current_node.nil?
            return current_node
        end

        if value > current_node.value
            current_node.right_child = delete(current_node.right_child, value)
        elsif value < current_node.value
            current_node.left_child = delete(current_node.left_child, value)
        end

        if current_node.left_child.nil?
            temp = current_node.right_child
            current_node = nil
            return temp
        elsif current_node.right_child.nil?
            temp = current_node.left_child
            current_node = nil
            return temp
        else
            succ_parent = current_node

            succ = current_node.right_child

            while succ.left_child != nil
                succ_parent = succ
                succ = succ.left_child
            end

            if succ_parent  != current_node
                succ_parent.left_child = succ.right_child
            else
                succ_parent.right_child = succ.right_child
            end

            current_node.value = succ.value

            succ = nil
            return current_node
        end

    end

    def level_order
        q = []
        l = []
        q.push(@root)
        while q.empty? == false
            current_node = q.first
            if current_node.left_child.nil? == false
                q.push(current_node.left_child)
            end
            if current_node.right_child.nil? == false
                q.push(current_node.right_child)
            end
            yield q[0] if block_given?
            l.push(q[0])
            q = q[1..-1]
        end
        if block_given? == false
            return l
        end
    end

    def inorder(current_node = @root )
        if current_node.nil?
            return
        end
        inorder(current_node.left_child)
        yield current_node if block_given?
        inorder(current_node.right_child)
    end

    def preorder(current_node = @root)
        if current_node.nil?
            return
        end
       p current_node.value

       preorder(current_node.left_child)
       preorder(current_node.right_child)
    end

    def postorder(current_node = @root)
        if current_node.nil?
            return
        end

        postorder(current_node.left_child)
        postorder(current_node.right_child)
        p current_node.value
        
    end



    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
        pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
    end
end
