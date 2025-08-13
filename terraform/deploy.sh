# Create the simple script
cat > simple-deploy.sh << 'EOF'
#!/bin/bash

echo "Starting Terraform deployment..."

# Check if main.tf exists
if [ ! -f "main.tf" ]; then
    echo "Error: main.tf not found. Make sure you're in the terraform directory."
    exit 1
fi

# Check if terraform.tfvars exists
if [ ! -f "terraform.tfvars" ]; then
    echo "Creating terraform.tfvars from example..."
    cp terraform.tfvars.example terraform.tfvars
    echo "Please edit terraform.tfvars with your settings and run this script again."
    exit 1
fi

echo "Initializing Terraform..."
terraform init

echo "Planning deployment..."
terraform plan

echo "Do you want to apply these changes? (yes/no)"
read answer

if [ "$answer" = "yes" ]; then
    echo "Applying changes..."
    terraform apply -auto-approve
    
    echo "Deployment complete!"
    echo "Your website URL:"
    terraform output website_url
else
    echo "Deployment cancelled."
fi
EOF

