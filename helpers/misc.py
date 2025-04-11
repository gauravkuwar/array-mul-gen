# Component classes
class parentSignal:
    def __init__(self, i):
        self.i = i

    def __repr__(self):
        return f"{self.__class__.__name__}({self.i})"


class parentSignalPipelined:
    def __init__(self, stage, i):
        self.i = i
        self.stage = stage

    def __repr__(self):
        return f"{self.__class__.__name__}({self.stage}, {self.i})"
    

class PP:
    def __init__(self, i, j):
        self.i = i
        self.j = j

    def __repr__(self):
        return f"{self.__class__.__name__}({self.i}, {self.i})"
    

class A1(parentSignalPipelined): pass
class B1(parentSignalPipelined): pass
class Y1(parentSignalPipelined): pass
class PL_REG(parentSignalPipelined): pass

class C(parentSignal): pass
class S(parentSignal): pass

# Functions for half and full adders
def ha(component_num, a, b, s, cout):
    return f"HA{component_num}: half_adder port map({a}, {b}, {s}, {cout});" 

def fa(component_num, a, b, cin, s, cout):
    return f"FA{component_num}: full_adder port map({a}, {b}, {cin}, {s}, {cout});"

# Helper func
def add_tabs(ls, tabs_count=1):
    tabs = '\t' * tabs_count
    for i in range(len(ls)):
        ls[i] = f"{tabs}{ls[i]}"

