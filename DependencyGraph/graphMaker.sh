tuist graph PomoNyang -d -t -f dot
sed -i '' '/Example/d; /ThirdParty_/d' graph.dot
dot -Tpng graph.dot -o DependencyGraph/pomonyang_graph.png
rm graph.dot

open DependencyGraph/pomonyang_graph.png
