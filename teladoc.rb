require "minitest/autorun"
#############################################################################
## PROBLEM 1
##
#############################################################################
## Fill in function below
# Given a list of strings, and integer, i
# find all strings less than length i, then group
# and count the number of strings by their length
#
# example:
# strings = [ 'abc', 'defg', 'hi' ,'a', 'b', 'ze', 'ae' ]
# i = 4
#
# output = { 1: 2, 2: 3, 3: 1 }
#
def filter_and_group(strings, i)
    occurences = {}
    strings.each do |str|
        if str.class == String # only if non-string values are a concern
            str = str.strip # only if leading/trailing whitespace is a concern
            len = str.length
            if len < i
                !!occurences[len] ? occurences[len] += 1 : occurences[len] = 1
            end
        end
    end
    occurences
end

class Test < Minitest::Test
  describe "returns a hash of string lengths pointing at the number of occurences" do
    it "returns correct groupings and occurences" do
        strings = [ 'abc', 'defg', 'hi' ,'a', 'b', 'ze', 'ae' ]
        i = 4
        assert_equal ({ 1=>2, 2=>3, 3=>1 }), filter_and_group(strings, i)
    end

    it "returns correct groupings and occurences with repeats" do
        strings = [ 'abc', 'defg', 'hi' ,'a', 'b', 'ze', 'ae', 'ae', 'ae' ]
        i = 4
        assert_equal ({ 1=>2, 2=>5, 3=>1 }), filter_and_group(strings, i)
    end

    it "returns correct groupings and occurences with single array elem" do
        strings = [ 'abcdsfadsgfadsf' ]
        i = 20
        assert_equal ({ 15=>1 }), filter_and_group(strings, i)
    end

    it "returns empty hash if elements are over specified length" do
        strings = [ 'abcdsfadsgfadsf', 'iadsfognlre',' bjgfkfafdsa' ]
        i = 4
        assert_equal ({ }), filter_and_group(strings, i)
    end

    str = "a" * 9999999

    it "returns for large strings" do
        strings = [ 'abc', 'defg', 'hi' ,'a', 'b', 'ze', str, str]
        i = 10000000
        assert_equal ({ 1=>2, 2=>2, 3=>1, 4=>1, 9999999=>2 }), filter_and_group(strings, i)
    end

    it "returns for large sets" do
        strings = ['b', 'cd', 'efg'] + str.chars
        i = 3
        assert_equal ({ 1=>10000000, 2=>1 }), filter_and_group(strings, i)
    end

    it "ignores non-string values" do
        strings = [ 1, 'defg', 'hi' , 0.5, 'b', 'ze' ]
        i = 10
        assert_equal ({ 1=>1, 2=>2, 4=>1 }), filter_and_group(strings, i)
    end

    it "can handle special characters" do
        strings = [ '1234453', '[]]\.©;#@!%^', '+_*&Ssß' , 0.5, 'b', 'ze' ]
        i = 10
        assert_equal ({ 1=>1, 2=>1, 7=>2 }), filter_and_group(strings, i)
    end

    it "ignores leading and trailing whitespace" do
        strings = [ 'abc  ', 'defg', '   hi' , 'a   ']
        i = 10
        assert_equal ({ 1=>1, 2=>1, 3=>1, 4=>1 }), filter_and_group(strings, i)
    end

    it "counts inner whitespace" do
        strings = [ 'a b c', 'de   fg', 'dh - - i' ]
        i = 10
        assert_equal ({ 5=>1, 7=>1, 8=>1 }), filter_and_group(strings, i)
    end

    it "can handle line breaks" do
        strings = [ "afsdf \n dsafds" ]
        i = 1000
        assert_equal ({ 14=>1 }), filter_and_group(strings, i)
    end

    it "can handle line breaks" do
        strings = [ "afsdf \n dsafds" ]
        i = 1000
        assert_equal ({ 14=>1 }), filter_and_group(strings, i)
    end
  end
end