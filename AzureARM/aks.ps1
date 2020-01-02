$location="SoutheastAsia"
$grpName="AKSRG"
$acrServer="acrDemo99"
$aksCluster="aksdemo99"
$nodeCount=1
$appId="e18ad3c7-4d5b-4586-bdbb-8c7ca12b60cf"
$password="bb880747-a178-43f2-b7d1-745250365176"


#Create ACR Server
az group create --name $grpName --location $location
az acr create --resource-group $grpName --name $acrServer --sku Standard
$acrId=(az acr show --name $acrServer --resource-group $grpName --query "id" --output tsv)
	
#Craete AKS Cluster
#同 $appId=(az aks show --resource-group $grpName --name $aksCluster --query "servicePrincipalProfile.clientId" --output tsv)
#az role assignment create --assignee $appId --role Reader --scope $acrId
#$objectId=(az ad sp show --id $appId --query "objectId" --output tsv)
#az role assignment create --assignee-object-id $objectId --role Reader --scope $acrId
$version=(az aks get-versions -l $location --query 'orchestrators[-1].orchestratorVersion' -o tsv)
az aks create --name $aksCluster --resource-group $grpName --node-count $nodeCount --generate-ssh-keys --service-principal $appId --client-secret  $password  --kubernetes-version $version --generate-ssh-keys

