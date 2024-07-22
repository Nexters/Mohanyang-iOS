TUIST_BUILD_CONFIG=prod tuist graph Mohanyang -d -t -f dot
sed -i '' '/ThirdParty_/d' graph.dot
dot -Tpng graph.dot -o DependencyGraph/mohanyang_prod_graph.png
rm graph.dot

TUIST_BUILD_CONFIG=dev tuist graph -d -f dot
sed -i '' '/ThirdParty_/d' graph.dot
dot -Tpng graph.dot -o DependencyGraph/mohanyang_dev_graph.png
rm graph.dot

open DependencyGraph/mohanyang_dev_graph.png
open DependencyGraph/mohanyang_prod_graph.png
