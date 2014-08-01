set print pretty on
set print object on
set print static-members on
set print vtbl on
set print demangle on
set demangle-style gnu-v3
set print sevenbit-strings off 

python
import sys

#  pretty printers for STL
#sys.path.insert(0, '/home/m918989/ide/gdb-pretty-printers')
#from libstdcxx.v6.printers import register_libstdcxx_printers
#register_libstdcxx_printers(None)

# pretty printers for Boost
sys.path.insert(1, '/home/m918989/ide/Boost-Pretty-Printer-master')
from boost.v1_40.printers import register_boost_printers
register_boost_printers(None)

end
