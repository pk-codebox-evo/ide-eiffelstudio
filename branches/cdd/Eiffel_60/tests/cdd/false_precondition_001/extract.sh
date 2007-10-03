\echo "Compiling project..."
ec -config tc_demo.ecf -target tc_demo -c_compile
echo "Running project..."
ec -config tc_demo.ecf -target tc_demo -loop < input.txt
echo "Done"