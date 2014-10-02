set print pretty on
set print object on
set print static-members on
set print vtbl on
set print demangle on
set demangle-style gnu-v3
set print sevenbit-strings off 

source ~/ide/stl-views-1.0.3.gdb

python
import sys

#  pretty printers for STL
sys.path.insert(0, '/home/vvolkov/ide/STLPrettyPrinters')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers(None)

# pretty printers for Boost
sys.path.insert(1, '/home/vvolkov/ide/Boost-Pretty-Printer')
from boost.printers import register_printer_gen
register_printer_gen(None)

end

