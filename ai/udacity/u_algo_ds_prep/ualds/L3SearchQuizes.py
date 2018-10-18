import unittest


#----  quiz  binary search practice  ----------

def binary_search(input_array,value):
    """returns index of value or -1 if value not found"""
    counter = 0
    lbord = 0
    rbord = len(input_array)
    while rbord - lbord > 1:
        counter += 1
        mid = lbord + len(input_array[lbord:rbord]) // 2
        if value == input_array[mid]:
            return mid
        elif  value > input_array[mid]:
            lbord = mid
        elif value < input_array[mid]:
            rbord = mid
        #print("step: {0}, lbord: {1}, rbord: {2}, subarr: {3}"
        #  .format(counter, lbord, rbord, input_array[lbord:rbord]))
    return -1


def test_binary_searh():
    il = [1,3,9,11,15,19,29]
    res = binary_search(il, 25)
    print("res", res)
    res = binary_search(il, 15)
    print("res", res)


def factorial_recursive(n):
    if  n <= 1:
        return 1  #base case  with defined exit (danger: infinite recursion)
    else:
        return n*(factorial_recursive(n-1))


def get_fib(n):
    if n <= 0:
        return 0
    if n == 1:
        return 1
    return get_fib(n-1) + get_fib(n-2)

def test_factorial_recursive():
    print("factorial 4:", factorial_recursive(4))

def test_fibonnaci():
    for i in range(8):
        print("fib {0}: {1}".format(i, get_fib(i)))

def main():
    test_binary_searh()
    test_factorial_recursive()
    test_fibonnaci()

if __name__ == '__main__':
        #unittest.main()
        main()



