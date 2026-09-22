import argparse
import math
import random
import datetime

def is_integer(int_str):
    if set(int_str).issubset(set("0123456789")):
        return True
    else:
        return False

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("-m", "--modulus", help="modulus")
    parser.add_argument("-a", "--multiplier", help="multiplier")
    parser.add_argument("-c", "--increment", help="increment")
    parser.add_argument("-l", "--bits_lower", type=int, help="bit range - lowest bit (index starting from 0)", default=-1)
    parser.add_argument("-u", "--bits_upper", type=int, help="bit range - highest bit (index starting from 0)", default=-1)
    parser.add_argument("-s", "--seed", type=int, help="seed initialization of RNG state", default=-1)
    parser.add_argument("-n", "--number_values", help="", default=-1)
    parser.add_argument("--file", type=str, help="binary output file with generated values", default="default")

    args = parser.parse_args()

    evaluated_params = args.modulus + args.multiplier + args.increment + args.number_values
    if not set(evaluated_params).issubset(set("0123456789*-+")):
        print("Allowed inputs charset is 0123456789*-+")
        exit(-1)

    args.modulus = int(eval(args.modulus))
    args.multiplier = int(eval(args.multiplier))
    args.increment = int(eval(args.increment))
    args.number_values = int(eval(args.number_values))

    if args.seed == -1:
        args.seed = int(datetime.datetime.now().timestamp())

    if args.bits_lower == -1 and args.bits_upper == -1:
        max_value = args.modulus - 1
    else:
        max_value = 2**(args.bits_upper - args.bits_lower + 1) - 1


    x = args.seed
    ints = [0]*args.number_values

    if  args.bits_upper != -1 or args.bits_lower != -1:
        mask = (1 << args.bits_upper)*2 - 1
        shift = args.bits_lower
        for i in range(args.number_values):
            x = (x*args.multiplier + args.increment) % args.modulus
            rnd = (x & mask) >> shift
            ints[i] = rnd
    else:
        for i in range(args.number_values):
            x = (x*args.multiplier + args.increment) % args.modulus
            ints[i] = x


    if args.file == 'default':
        print(ints)
        exit(0)

    file = open(args.file, 'wb')

    rnd_size_bytes = math.ceil(max_value.bit_length()/8)
    a = bytearray()
    for value in ints:
        a += value.to_bytes(rnd_size_bytes, 'little')

    file.write(a)
    file.close()
    print(f"{args.file} generated")


# python3 LCG.py -m 2**48 -a 25214903917 -c 11 -l 16 -u 47 -n 10
#will give [0, 4232237, 178803790, 758674372, 1565954732, 392261992, 396415378, 2092582042, 2262375224, 1951776693]

# python3 LCG.py -m 2**48 -a 25214903917 -c 11 -l 16 -u 47 -n 10**8 --file java_util_rand.bin
