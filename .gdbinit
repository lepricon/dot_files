set print pretty on
set print object on
set print static-members on
set print vtbl on
set print demangle on
set demangle-style gnu-v3
set print sevenbit-strings off

source ~/cfg/gdb/stl-views/stl-views.gdb

python
import sys

HOME_DIR='/home/vvolkov'

#  pretty printers for STL
sys.path.insert(0, HOME_DIR + '/cfg/gdb/python')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers(None)

# pretty printers for Boost
sys.path.insert(1, HOME_DIR + '/cfg/gdb/Boost-Pretty-Printer')
import boost.all
boost.register_printers()

end

