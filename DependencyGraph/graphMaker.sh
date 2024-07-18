TUIST_BUILD_CONFIG=prod tuist graph PomoNyang -d -t -f dot
sed -i '' '/ThirdParty_/d' graph.dot
dot -Tpng graph.dot -o DependencyGraph/pomonyang_prod_graph.png
rm graph.dot

TUIST_BUILD_CONFIG=dev tuist graph -d -f dot
sed -i '' '/ThirdParty_/d' graph.dot
dot -Tpng graph.dot -o DependencyGraph/pomonyang_dev_graph.png
rm graph.dot

open DependencyGraph/pomonyang_dev_graph.png
open DependencyGraph/pomonyang_prod_graph.png
