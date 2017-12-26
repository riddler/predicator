module Predicator
  module Visitors
    class Visitor
      DISPATCH_CACHE = Hash.new { |h,k|
        h[k] = "visit_#{k}"
      }

      def accept node
        visit node
      end

      private

      def visit node
        send DISPATCH_CACHE[node.type], node
      end

      def visit_children node
        node.children.each {|child| visit child}
      end

      def terminal node; end

      def visit_ARRAY node
        node.left.each{ |item| visit item }
      end

      visit_children_methods = %w(
        visit_EQ visit_GT visit_LT
        visit_NOT visit_GROUP visit_BOOL
        visit_IN visit_NOTIN visit_BETWEEN
        visit_DATEAGO visit_DATEFROMNOW
        visit_AND visit_OR
      )
      visit_children_methods.each do |method_name|
        define_method method_name do |node|
          visit_children node
        end
      end

      %w( visit_INTEQ visit_STREQ visit_DATEQ ).each do |method_name|
        define_method method_name do |node|
          visit_EQ node
        end
      end

      %w( visit_INTGT visit_STRGT visit_DATGT ).each do |method_name|
        define_method method_name do |node|
          visit_GT node
        end
      end

      %w( visit_INTLT visit_STRLT visit_DATLT ).each do |method_name|
        define_method method_name do |node|
          visit_LT node
        end
      end

      %w( visit_INTIN visit_STRIN ).each do |method_name|
        define_method method_name do |node|
          visit_IN node
        end
      end

      %w( visit_INTNOTIN visit_STRNOTIN ).each do |method_name|
        define_method method_name do |node|
          visit_NOTIN node
        end
      end

      %w( visit_INTBETWEEN visit_DATBETWEEN ).each do |method_name|
        define_method method_name do |node|
          visit_BETWEEN node
        end
      end

      terminal_methods = %w(
        visit_TRUE visit_FALSE
        visit_DATE visit_DURATION
        visit_INTEGER visit_STRING visit_VARIABLE
        visit_BLANK visit_PRESENT
      )
      terminal_methods.each do |method_name|
        define_method method_name do |node|
          terminal node
        end
      end

      array_methods = %w(
        visit_INTARRAY visit_STRARRAY
      )
      array_methods.each do |method_name|
        define_method method_name do |node|
          visit_ARRAY node
        end
      end
    end
  end
end
