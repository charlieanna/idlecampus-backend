# Kubectl Learning Content for Kubernetes Complete Guide
# Creates detailed kubectl command lessons for each module

puts "Creating kubectl learning lessons..."

k8s_course = Course.find_by(slug: 'kubernetes-complete-guide')

unless k8s_course
  puts "❌ Kubernetes Complete Guide course not found!"
  exit
end

# Module 2: Working with Pods
mod2 = k8s_course.course_modules.find_by(slug: 'working-with-pods')
if mod2
  lesson2 = CourseLesson.find_or_create_by!(title: "Working with Pods") do |l|
    l.content = <<~MARKDOWN
      # Working with Pods

      Pods are the smallest deployable units in Kubernetes. They encapsulate one or more containers that share storage and network resources.

      ## Key Commands

      ### Creating Pods

      ```bash
      # Create a pod from a YAML file
      kubectl apply -f pod.yaml

      # Create a pod imperatively
      kubectl run nginx --image=nginx:1.25

      # Create pod with custom command
      kubectl run busybox --image=busybox -- sleep 3600

      # Create pod with environment variable
      kubectl run nginx --image=nginx --env="ENV=production"
      ```

      ### Viewing Pods

      ```bash
      # List all pods in current namespace
      kubectl get pods

      # List pods with more details
      kubectl get pods -o wide

      # List pods in all namespaces
      kubectl get pods --all-namespaces
      kubectl get pods -A

      # Get detailed information about a pod
      kubectl describe pod nginx

      # Get pod YAML definition
      kubectl get pod nginx -o yaml

      # Watch pods in real-time
      kubectl get pods --watch
      ```

      ### Managing Pods

      ```bash
      # Delete a pod
      kubectl delete pod nginx

      # Delete pod immediately (force)
      kubectl delete pod nginx --force --grace-period=0

      # View pod logs
      kubectl logs nginx

      # Follow logs (like tail -f)
      kubectl logs -f nginx

      # View logs from previous container instance
      kubectl logs nginx --previous

      # Execute commands in a pod
      kubectl exec nginx -- ls /usr/share/nginx/html

      # Open interactive shell
      kubectl exec -it nginx -- bash

      # Copy files to/from pod
      kubectl cp ./index.html nginx:/usr/share/nginx/html/
      kubectl cp nginx:/etc/nginx/nginx.conf ./nginx.conf
      ```

      ## Pod Lifecycle

      Pods go through these phases:
      - **Pending**: Pod is created but containers aren't running yet
      - **Running**: All containers are running
      - **Succeeded**: All containers terminated successfully
      - **Failed**: At least one container terminated with failure
      - **Unknown**: Pod state cannot be determined

      ## Multi-Container Pods

      Pods can run multiple containers that work together:

      ```yaml
      apiVersion: v1
      kind: Pod
      metadata:
        name: multi-container-pod
      spec:
        containers:
        - name: app
          image: nginx
          volumeMounts:
          - name: shared-data
            mountPath: /usr/share/nginx/html
        - name: sidecar
          image: busybox
          command: ['sh', '-c', 'while true; do date >> /data/index.html; sleep 10; done']
          volumeMounts:
          - name: shared-data
            mountPath: /data
        volumes:
        - name: shared-data
          emptyDir: {}
      ```

      ### Common Patterns

      1. **Sidecar**: Helper container that enhances main container (logging, monitoring)
      2. **Ambassador**: Proxy container that simplifies network access
      3. **Adapter**: Transforms output of main container to standard format

      ### Working with Multi-Container Pods

      ```bash
      # View logs from specific container
      kubectl logs multi-container-pod -c app
      kubectl logs multi-container-pod -c sidecar

      # Execute in specific container
      kubectl exec -it multi-container-pod -c app -- bash
      ```

      Try these commands in the hands-on lab!
    MARKDOWN
    l.reading_time_minutes = 10
  end

  # Find max sequence order
  max_seq = mod2.module_items.maximum(:sequence_order) || 1

  # Link lesson to module
  ModuleItem.find_or_create_by!(
    course_module: mod2,
    item_type: 'CourseLesson',
    item: lesson2,
    sequence_order: max_seq + 1
  ) { |item| item.required = true }

  puts "  ✅ Created 'Working with Pods' lesson"
end

# Module 3: Deployments & ReplicaSets
mod3 = k8s_course.course_modules.find_by(slug: 'deployments-replicasets')
if mod3
  lesson3 = CourseLesson.find_or_create_by!(title: "Mastering Deployments") do |l|
    l.content = <<~MARKDOWN
      # Mastering Deployments

      Deployments provide declarative updates for Pods and ReplicaSets, enabling rolling updates and rollbacks.

      ## Creating Deployments

      ```bash
      # Imperative creation
      kubectl create deployment nginx --image=nginx:1.25 --replicas=3

      # With resource limits
      kubectl create deployment nginx --image=nginx:1.25 --replicas=3 \\
        --requests="cpu=100m,memory=128Mi" \\
        --limits="cpu=200m,memory=256Mi"

      # Declarative creation from YAML
      kubectl apply -f deployment.yaml

      # Create from existing deployment (dry-run)
      kubectl create deployment nginx --image=nginx:1.25 --dry-run=client -o yaml > deployment.yaml
      ```

      ## Viewing Deployments

      ```bash
      # List deployments
      kubectl get deployments
      kubectl get deploy

      # Describe deployment (shows events and status)
      kubectl describe deployment nginx

      # Get deployment YAML
      kubectl get deployment nginx -o yaml

      # Check deployment status
      kubectl rollout status deployment/nginx
      ```

      ## Scaling Deployments

      ```bash
      # Scale to specific number of replicas
      kubectl scale deployment nginx --replicas=5

      # Autoscale based on CPU usage
      kubectl autoscale deployment nginx --min=2 --max=10 --cpu-percent=80

      # View autoscalers
      kubectl get hpa
      ```

      ## Updating Deployments

      ```bash
      # Update container image
      kubectl set image deployment/nginx nginx=nginx:1.26

      # Update multiple images
      kubectl set image deployment/nginx nginx=nginx:1.26 sidecar=busybox:1.36

      # Update via editing
      kubectl edit deployment nginx

      # Update via applying modified YAML
      kubectl apply -f deployment.yaml

      # Patch deployment
      kubectl patch deployment nginx -p '{"spec":{"replicas":4}}'
      ```

      ## Rollout Management

      ```bash
      # Pause rollout (stop updates)
      kubectl rollout pause deployment/nginx

      # Resume rollout
      kubectl rollout resume deployment/nginx

      # View rollout history
      kubectl rollout history deployment/nginx

      # View specific revision
      kubectl rollout history deployment/nginx --revision=2

      # Rollback to previous version
      kubectl rollout undo deployment/nginx

      # Rollback to specific revision
      kubectl rollout undo deployment/nginx --to-revision=2

      # Restart deployment (rolling restart)
      kubectl rollout restart deployment/nginx
      ```

      ## ReplicaSets

      Deployments manage ReplicaSets automatically, but you can inspect them:

      ```bash
      # List replicasets
      kubectl get replicasets
      kubectl get rs

      # Describe replicaset
      kubectl describe rs nginx-deployment-5d59d67564

      # Get replicaset for specific deployment
      kubectl get rs -l app=nginx
      ```

      ## Deployment Strategies

      ### Rolling Update (Default)
      Gradually replaces old pods with new ones:

      ```yaml
      spec:
        strategy:
          type: RollingUpdate
          rollingUpdate:
            maxSurge: 1        # Max pods above desired count
            maxUnavailable: 0  # Max pods unavailable during update
      ```

      ### Recreate
      Terminates all pods before creating new ones:

      ```yaml
      spec:
        strategy:
          type: Recreate
      ```

      ## Useful Commands

      ```bash
      # Delete deployment
      kubectl delete deployment nginx

      # Delete deployment but keep pods
      kubectl delete deployment nginx --cascade=orphan

      # Export deployment to file
      kubectl get deployment nginx -o yaml > nginx-deployment.yaml

      # Create deployment from URL
      kubectl apply -f https://k8s.io/examples/application/deployment.yaml
      ```

      Practice deployment management in the labs!
    MARKDOWN
    l.reading_time_minutes = 12
  end

  max_seq = mod3.module_items.maximum(:sequence_order) || 1

  ModuleItem.find_or_create_by!(
    course_module: mod3,
    item_type: 'CourseLesson',
    item: lesson3,
    sequence_order: max_seq + 1
  ) { |item| item.required = true }

  puts "  ✅ Created 'Mastering Deployments' lesson"
end

# Module 4: Services & Networking
mod4 = k8s_course.course_modules.find_by(slug: 'services-networking')
if mod4
  lesson4 = CourseLesson.find_or_create_by!(title: "Kubernetes Services & Networking") do |l|
    l.content = <<~MARKDOWN
      # Kubernetes Services & Networking

      Services expose Pods to network traffic and enable load balancing across multiple Pod replicas.

      ## Creating Services

      ### ClusterIP (Default - Internal Only)

      ```bash
      # Create ClusterIP service
      kubectl create service clusterip my-service --tcp=80:8080

      # Expose existing deployment
      kubectl expose deployment nginx --port=80 --target-port=8080

      # Create from YAML
      kubectl apply -f service.yaml
      ```

      ### NodePort (External Access via Node IP)

      ```bash
      # Create NodePort service
      kubectl create service nodeport my-service --tcp=80:8080 --node-port=30080

      # Expose deployment as NodePort
      kubectl expose deployment nginx --type=NodePort --port=80
      ```

      ### LoadBalancer (Cloud Load Balancer)

      ```bash
      # Create LoadBalancer service
      kubectl expose deployment nginx --type=LoadBalancer --port=80

      # Check external IP
      kubectl get service nginx
      ```

      ## Viewing Services

      ```bash
      # List all services
      kubectl get services
      kubectl get svc

      # List services with more details
      kubectl get svc -o wide

      # Describe service (shows endpoints)
      kubectl describe service my-service

      # Get service YAML
      kubectl get svc my-service -o yaml

      # View service endpoints
      kubectl get endpoints my-service
      ```

      ## Service Discovery & DNS

      Every service gets a DNS name automatically:

      ```bash
      # Format: <service-name>.<namespace>.svc.cluster.local
      # Short form within same namespace: <service-name>

      # Test DNS resolution
      kubectl run debug --image=nicolaka/netshoot -it --rm -- bash
      nslookup my-service
      nslookup my-service.default.svc.cluster.local

      # Test service connectivity
      curl http://my-service
      wget -O- http://my-service:80
      ```

      ## Port Forwarding

      Access services locally for debugging:

      ```bash
      # Forward local port to service
      kubectl port-forward service/my-service 8080:80

      # Forward to pod directly
      kubectl port-forward pod/nginx 8080:80

      # Listen on all interfaces
      kubectl port-forward --address 0.0.0.0 service/my-service 8080:80
      ```

      ## Headless Services

      For direct pod access (stateful apps):

      ```bash
      # Create headless service (ClusterIP: None)
      kubectl create service clusterip my-service --clusterip=None --tcp=80:8080
      ```

      ## Service Management

      ```bash
      # Update service
      kubectl edit service my-service
      kubectl apply -f service.yaml

      # Delete service
      kubectl delete service my-service

      # Delete multiple services
      kubectl delete service my-service1 my-service2

      # Delete services by label
      kubectl delete service -l app=nginx
      ```

      ## Debugging Network Issues

      ```bash
      # Check if service has endpoints
      kubectl get endpoints my-service

      # Test connectivity from debug pod
      kubectl run debug --image=busybox -it --rm -- wget -O- http://my-service

      # Check service selector matches pods
      kubectl get pods -l app=nginx
      kubectl get service my-service -o yaml | grep selector

      # View service events
      kubectl get events --field-selector involvedObject.name=my-service
      ```

      ## Network Policies (Traffic Control)

      ```bash
      # List network policies
      kubectl get networkpolicies
      kubectl get netpol

      # Describe network policy
      kubectl describe networkpolicy my-policy

      # Delete network policy
      kubectl delete networkpolicy my-policy
      ```

      ## Ingress (HTTP/HTTPS Routing)

      ```bash
      # List ingress resources
      kubectl get ingress
      kubectl get ing

      # Describe ingress
      kubectl describe ingress my-ingress

      # Get ingress with addresses
      kubectl get ingress -o wide

      # Delete ingress
      kubectl delete ingress my-ingress
      ```

      Practice service creation and troubleshooting in the labs!
    MARKDOWN
    l.reading_time_minutes = 15
  end

  max_seq = mod4.module_items.maximum(:sequence_order) || 1

  ModuleItem.find_or_create_by!(
    course_module: mod4,
    item_type: 'CourseLesson',
    item: lesson4,
    sequence_order: max_seq + 1
  ) { |item| item.required = true }

  puts "  ✅ Created 'Kubernetes Services & Networking' lesson"
end

# Module 5: Configuration Management
mod5 = k8s_course.course_modules.find_by(slug: 'configuration-management')
if mod5
  lesson5 = CourseLesson.find_or_create_by!(title: "ConfigMaps & Secrets") do |l|
    l.content = <<~MARKDOWN
      # ConfigMaps & Secrets

      Manage application configuration and sensitive data separately from container images.

      ## ConfigMaps

      Store non-confidential configuration data as key-value pairs.

      ### Creating ConfigMaps

      ```bash
      # From literal values
      kubectl create configmap app-config \\
        --from-literal=ENV=production \\
        --from-literal=LOG_LEVEL=info

      # From file
      kubectl create configmap app-config --from-file=config.properties

      # From directory (all files in directory)
      kubectl create configmap app-config --from-file=./config/

      # From env file
      kubectl create configmap app-config --from-env-file=app.env

      # From YAML
      kubectl apply -f configmap.yaml
      ```

      ### Viewing ConfigMaps

      ```bash
      # List configmaps
      kubectl get configmaps
      kubectl get cm

      # Describe configmap
      kubectl describe configmap app-config

      # Get configmap data
      kubectl get configmap app-config -o yaml
      kubectl get configmap app-config -o json

      # Get specific key value
      kubectl get configmap app-config -o jsonpath='{.data.ENV}'
      ```

      ### Using ConfigMaps

      **As Environment Variables:**
      ```bash
      # Create pod using configmap
      kubectl run nginx --image=nginx --env="CONFIG=$(kubectl get cm app-config -o jsonpath='{.data.ENV}')"

      # Or in YAML:
      # env:
      # - name: ENV
      #   valueFrom:
      #     configMapKeyRef:
      #       name: app-config
      #       key: ENV
      ```

      **As Volume Mounts:**
      ```bash
      # ConfigMap mounted as files in /etc/config
      # Each key becomes a file
      ```

      ### Updating ConfigMaps

      ```bash
      # Edit configmap
      kubectl edit configmap app-config

      # Update from file
      kubectl create configmap app-config --from-file=config.properties --dry-run=client -o yaml | kubectl apply -f -

      # Delete and recreate
      kubectl delete configmap app-config
      kubectl create configmap app-config --from-file=config.properties
      ```

      ## Secrets

      Store sensitive information like passwords, tokens, and keys.

      ### Creating Secrets

      ```bash
      # Generic secret from literals
      kubectl create secret generic db-secret \\
        --from-literal=username=admin \\
        --from-literal=password=secret123

      # From file
      kubectl create secret generic db-secret --from-file=./credentials.txt

      # TLS secret
      kubectl create secret tls tls-secret \\
        --cert=path/to/tls.crt \\
        --key=path/to/tls.key

      # Docker registry secret
      kubectl create secret docker-registry regcred \\
        --docker-server=myregistry.com \\
        --docker-username=user \\
        --docker-password=pass \\
        --docker-email=user@example.com

      # From YAML (base64 encoded values)
      kubectl apply -f secret.yaml
      ```

      ### Viewing Secrets

      ```bash
      # List secrets
      kubectl get secrets

      # Describe secret (values hidden)
      kubectl describe secret db-secret

      # Get secret YAML (base64 encoded)
      kubectl get secret db-secret -o yaml

      # Decode secret value
      kubectl get secret db-secret -o jsonpath='{.data.password}' | base64 -d

      # Decode all secret values
      kubectl get secret db-secret -o json | jq '.data | map_values(@base64d)'
      ```

      ### Using Secrets

      **As Environment Variables:**
      ```bash
      # env:
      # - name: DB_PASSWORD
      #   valueFrom:
      #     secretKeyRef:
      #       name: db-secret
      #       key: password
      ```

      **As Volume Mounts:**
      ```bash
      # Secret mounted as files in /etc/secrets
      # Each key becomes a file with decoded value
      ```

      ### Managing Secrets

      ```bash
      # Update secret
      kubectl edit secret db-secret

      # Delete secret
      kubectl delete secret db-secret

      # Patch secret (add new key)
      kubectl patch secret db-secret -p '{"data":{"api_key":"'"$(echo -n 'newkey123' | base64)"'"}}'
      ```

      ## Best Practices

      ```bash
      # Create from file and delete file immediately
      kubectl create secret generic db-secret --from-file=./credentials.txt && rm ./credentials.txt

      # Use .gitignore for secret files
      echo "credentials.txt" >> .gitignore

      # View which pods use a config/secret
      kubectl get pods -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.volumes[*].configMap.name}{"\n"}{end}'
      ```

      ## Troubleshooting

      ```bash
      # Check if secret exists
      kubectl get secret db-secret

      # Verify secret is mounted in pod
      kubectl exec my-pod -- ls /etc/secrets

      # View secret content in pod
      kubectl exec my-pod -- cat /etc/secrets/password

      # Check environment variables in pod
      kubectl exec my-pod -- env | grep DB_
      ```

      Practice configuration management in the labs!
    MARKDOWN
    l.reading_time_minutes = 15
  end

  max_seq = mod5.module_items.maximum(:sequence_order) || 1

  ModuleItem.find_or_create_by!(
    course_module: mod5,
    item_type: 'CourseLesson',
    item: lesson5,
    sequence_order: max_seq + 1
  ) { |item| item.required = true }

  puts "  ✅ Created 'ConfigMaps & Secrets' lesson"
end

# Module 6: Storage & Persistence
mod6 = k8s_course.course_modules.find_by(slug: 'storage-persistence')
if mod6
  lesson6 = CourseLesson.find_or_create_by!(title: "Persistent Volumes & Storage") do |l|
    l.content = <<~MARKDOWN
      # Persistent Volumes & Storage

      Provide persistent storage for stateful applications in Kubernetes.

      ## Persistent Volumes (PV)

      Cluster-wide storage resources provisioned by administrators.

      ### Viewing Persistent Volumes

      ```bash
      # List all persistent volumes
      kubectl get pv

      # List with more details
      kubectl get pv -o wide

      # Describe PV
      kubectl describe pv pv-name

      # Get PV YAML
      kubectl get pv pv-name -o yaml

      # Filter by status
      kubectl get pv --field-selector=status.phase=Available
      ```

      ## Persistent Volume Claims (PVC)

      User requests for storage that bind to available PVs.

      ### Creating PVCs

      ```bash
      # Create PVC from YAML
      kubectl apply -f pvc.yaml

      # View PVC definition example
      cat << EOF | kubectl apply -f -
      apiVersion: v1
      kind: PersistentVolumeClaim
      metadata:
        name: my-pvc
      spec:
        accessModes:
        - ReadWriteOnce
        resources:
          requests:
            storage: 1Gi
        storageClassName: standard
      EOF
      ```

      ### Viewing PVCs

      ```bash
      # List PVCs
      kubectl get pvc

      # List PVCs in all namespaces
      kubectl get pvc -A

      # Describe PVC (shows binding status)
      kubectl describe pvc my-pvc

      # Get PVC YAML
      kubectl get pvc my-pvc -o yaml

      # Check PVC status
      kubectl get pvc my-pvc -o jsonpath='{.status.phase}'
      ```

      ### Using PVCs in Pods

      ```bash
      # Create pod using PVC
      cat << EOF | kubectl apply -f -
      apiVersion: v1
      kind: Pod
      metadata:
        name: app-pod
      spec:
        containers:
        - name: app
          image: nginx
          volumeMounts:
          - name: storage
            mountPath: /data
        volumes:
        - name: storage
          persistentVolumeClaim:
            claimName: my-pvc
      EOF
      ```

      ### Managing PVCs

      ```bash
      # Delete PVC
      kubectl delete pvc my-pvc

      # Delete PVC and wait for deletion
      kubectl delete pvc my-pvc --wait=true

      # Expand PVC (if storage class supports it)
      kubectl patch pvc my-pvc -p '{"spec":{"resources":{"requests":{"storage":"2Gi"}}}}'
      ```

      ## Storage Classes

      Define different storage tiers with automatic provisioning.

      ### Viewing Storage Classes

      ```bash
      # List storage classes
      kubectl get storageclass
      kubectl get sc

      # Describe storage class
      kubectl describe storageclass standard

      # Get default storage class
      kubectl get sc -o jsonpath='{.items[?(@.metadata.annotations.storageclass\.kubernetes\.io/is-default-class=="true")].metadata.name}'
      ```

      ### Setting Default Storage Class

      ```bash
      # Set as default
      kubectl patch storageclass standard -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

      # Remove default designation
      kubectl patch storageclass standard -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
      ```

      ## Volume Types

      ### emptyDir (Temporary Storage)

      ```bash
      # Deleted when pod is removed
      # volumes:
      # - name: cache
      #   emptyDir: {}
      ```

      ### hostPath (Node Filesystem)

      ```bash
      # Mount directory from node
      # volumes:
      # - name: data
      #   hostPath:
      #     path: /mnt/data
      #     type: DirectoryOrCreate
      ```

      ## Debugging Storage Issues

      ```bash
      # Check PVC binding status
      kubectl get pvc my-pvc -o jsonpath='{.status.phase}'

      # View PVC events
      kubectl describe pvc my-pvc

      # Check which pod uses PVC
      kubectl get pods -o json | jq '.items[] | select(.spec.volumes[]?.persistentVolumeClaim.claimName=="my-pvc") | .metadata.name'

      # Verify volume is mounted in pod
      kubectl exec app-pod -- df -h /data

      # Check volume contents
      kubectl exec app-pod -- ls -la /data

      # Write test file
      kubectl exec app-pod -- sh -c 'echo "test" > /data/test.txt'

      # Verify persistence after pod recreation
      kubectl delete pod app-pod
      # Wait for pod to recreate
      kubectl exec app-pod -- cat /data/test.txt
      ```

      ## StatefulSet Storage

      StatefulSets use volumeClaimTemplates for automatic PVC creation:

      ```bash
      # View PVCs created by StatefulSet
      kubectl get pvc -l app=mysql

      # Scale StatefulSet (creates new PVCs)
      kubectl scale statefulset mysql --replicas=3

      # Delete StatefulSet but keep PVCs
      kubectl delete statefulset mysql --cascade=orphan
      ```

      ## Cleanup

      ```bash
      # Delete PVC (PV reclaim policy determines what happens)
      kubectl delete pvc my-pvc

      # View reclaim policy
      kubectl get pv pv-name -o jsonpath='{.spec.persistentVolumeReclaimPolicy}'

      # Manually delete PV
      kubectl delete pv pv-name

      # Remove finalizer if PV is stuck
      kubectl patch pv pv-name -p '{"metadata":{"finalizers":null}}'
      ```

      Practice storage management in the labs!
    MARKDOWN
    l.reading_time_minutes = 15
  end

  max_seq = mod6.module_items.maximum(:sequence_order) || 1

  ModuleItem.find_or_create_by!(
    course_module: mod6,
    item_type: 'CourseLesson',
    item: lesson6,
    sequence_order: max_seq + 1
  ) { |item| item.required = true }

  puts "  ✅ Created 'Persistent Volumes & Storage' lesson"
end

# Module 7: Advanced Workloads
mod7 = k8s_course.course_modules.find_by(slug: 'advanced-workloads')
if mod7
  lesson7 = CourseLesson.find_or_create_by!(title: "StatefulSets, DaemonSets & Jobs") do |l|
    l.content = <<~MARKDOWN
      # StatefulSets, DaemonSets & Jobs

      Specialized workload controllers for stateful apps, system services, and batch tasks.

      ## StatefulSets

      For stateful applications requiring stable identities and storage.

      ### Creating StatefulSets

      ```bash
      # Create from YAML
      kubectl apply -f statefulset.yaml

      # View StatefulSet status
      kubectl get statefulset
      kubectl get sts
      ```

      ### Managing StatefulSets

      ```bash
      # Scale StatefulSet
      kubectl scale statefulset mysql --replicas=3

      # Update image
      kubectl set image statefulset/mysql mysql=mysql:8.0

      # View rollout status
      kubectl rollout status statefulset/mysql

      # Delete StatefulSet (keeps PVCs)
      kubectl delete statefulset mysql --cascade=orphan
      ```

      ### StatefulSet Pods

      ```bash
      # List pods (predictable names)
      kubectl get pods -l app=mysql

      # Pods named: mysql-0, mysql-1, mysql-2

      # Access specific pod
      kubectl exec -it mysql-0 -- bash

      # View pod order
      kubectl get pods -l app=mysql --sort-by=.metadata.creationTimestamp
      ```

      ## DaemonSets

      Ensure all nodes run a copy of a pod (monitoring agents, log collectors).

      ### Viewing DaemonSets

      ```bash
      # List daemonsets
      kubectl get daemonsets
      kubectl get ds

      # List daemonsets in kube-system
      kubectl get ds -n kube-system

      # Describe daemonset
      kubectl describe ds node-exporter

      # Get DaemonSet YAML
      kubectl get ds node-exporter -o yaml
      ```

      ### Managing DaemonSets

      ```bash
      # Update DaemonSet image
      kubectl set image daemonset/node-exporter exporter=prom/node-exporter:v1.5.0

      # View rollout status
      kubectl rollout status daemonset/node-exporter

      # View rollout history
      kubectl rollout history daemonset/node-exporter

      # Rollback
      kubectl rollout undo daemonset/node-exporter

      # Delete DaemonSet
      kubectl delete daemonset node-exporter
      ```

      ## Jobs

      Run batch tasks to completion.

      ### Creating Jobs

      ```bash
      # Create simple job
      kubectl create job pi --image=perl:5.34 -- perl -Mbignum=bpi -wle 'print bpi(2000)'

      # Create from YAML
      kubectl apply -f job.yaml

      # Create job with completions
      kubectl create job process-items --image=busybox --completions=5 -- /bin/sh -c 'echo Processing item'
      ```

      ### Viewing Jobs

      ```bash
      # List jobs
      kubectl get jobs

      # Describe job
      kubectl describe job pi

      # View job pods
      kubectl get pods -l job-name=pi

      # View job logs
      kubectl logs job/pi
      ```

      ### Managing Jobs

      ```bash
      # Wait for job to complete
      kubectl wait --for=condition=complete --timeout=300s job/pi

      # Delete job
      kubectl delete job pi

      # Delete job and its pods
      kubectl delete job pi --cascade=foreground

      # Keep pods after job completion
      # Set ttlSecondsAfterFinished: 100 in job spec
      ```

      ## CronJobs

      Run jobs on a schedule.

      ### Creating CronJobs

      ```bash
      # Create cronjob
      kubectl create cronjob backup --image=backup-tool --schedule="0 2 * * *" -- /backup.sh

      # Create from YAML
      kubectl apply -f cronjob.yaml
      ```

      ### Viewing CronJobs

      ```bash
      # List cronjobs
      kubectl get cronjobs
      kubectl get cj

      # Describe cronjob
      kubectl describe cronjob backup

      # View cronjob schedule
      kubectl get cronjob backup -o jsonpath='{.spec.schedule}'

      # View jobs created by cronjob
      kubectl get jobs -l cronjob=backup
      ```

      ### Managing CronJobs

      ```bash
      # Suspend cronjob (stop scheduling)
      kubectl patch cronjob backup -p '{"spec":{"suspend":true}}'

      # Resume cronjob
      kubectl patch cronjob backup -p '{"spec":{"suspend":false}}'

      # Manually trigger cronjob
      kubectl create job --from=cronjob/backup backup-manual

      # Update schedule
      kubectl patch cronjob backup -p '{"spec":{"schedule":"0 3 * * *"}}'

      # Delete cronjob
      kubectl delete cronjob backup
      ```

      ## Resource Management

      ### View Resource Usage

      ```bash
      # Node resource usage
      kubectl top nodes

      # Pod resource usage
      kubectl top pods

      # Pod usage in namespace
      kubectl top pods -n kube-system

      # Sort by CPU
      kubectl top pods --sort-by=cpu

      # Sort by memory
      kubectl top pods --sort-by=memory

      # Container-level usage
      kubectl top pod my-pod --containers
      ```

      ### Resource Quotas

      ```bash
      # List resource quotas
      kubectl get resourcequotas
      kubectl get quota

      # Describe quota
      kubectl describe resourcequota my-quota

      # Check namespace resource usage
      kubectl describe namespace production
      ```

      ### Limit Ranges

      ```bash
      # List limit ranges
      kubectl get limitranges
      kubectl get limits

      # Describe limit range
      kubectl describe limitrange my-limits
      ```

      Practice advanced workloads in the labs!
    MARKDOWN
    l.reading_time_minutes = 18
  end

  max_seq = mod7.module_items.maximum(:sequence_order) || 1

  ModuleItem.find_or_create_by!(
    course_module: mod7,
    item_type: 'CourseLesson',
    item: lesson7,
    sequence_order: max_seq + 1
  ) { |item| item.required = true }

  puts "  ✅ Created 'StatefulSets, DaemonSets & Jobs' lesson"
end

# Module 9: Observability
mod9 = k8s_course.course_modules.find_by(slug: 'observability')
if mod9
  lesson9 = CourseLesson.find_or_create_by!(title: "Monitoring & Debugging") do |l|
    l.content = <<~MARKDOWN
      # Monitoring & Debugging

      Monitor applications and troubleshoot issues in Kubernetes clusters.

      ## Pod Debugging

      ### Viewing Pod Status

      ```bash
      # List pods with status
      kubectl get pods

      # Watch pods in real-time
      kubectl get pods --watch

      # Get pod with detailed status
      kubectl get pod my-pod -o wide

      # Describe pod (shows events)
      kubectl describe pod my-pod

      # Get pod YAML
      kubectl get pod my-pod -o yaml
      ```

      ### Viewing Logs

      ```bash
      # View pod logs
      kubectl logs my-pod

      # Follow logs (tail -f)
      kubectl logs -f my-pod

      # Logs from previous container instance
      kubectl logs my-pod --previous

      # Logs from specific container in pod
      kubectl logs my-pod -c container-name

      # Logs with timestamps
      kubectl logs my-pod --timestamps

      # Last N lines
      kubectl logs my-pod --tail=50

      # Logs since timestamp
      kubectl logs my-pod --since-time=2024-01-01T00:00:00Z

      # Logs since duration
      kubectl logs my-pod --since=1h

      # Logs from all pods with label
      kubectl logs -l app=nginx

      # Stream logs from all containers in pod
      kubectl logs my-pod --all-containers=true --follow
      ```

      ### Execute Commands

      ```bash
      # Open interactive shell
      kubectl exec -it my-pod -- /bin/bash
      kubectl exec -it my-pod -- /bin/sh

      # Run single command
      kubectl exec my-pod -- ls /app
      kubectl exec my-pod -- cat /etc/config/app.conf

      # Execute in specific container
      kubectl exec -it my-pod -c container-name -- bash

      # Run command with environment variables
      kubectl exec my-pod -- env
      ```

      ### Port Forwarding

      ```bash
      # Forward local port to pod
      kubectl port-forward my-pod 8080:80

      # Forward to service
      kubectl port-forward service/my-service 8080:80

      # Forward to deployment
      kubectl port-forward deployment/nginx 8080:80

      # Listen on all interfaces
      kubectl port-forward --address 0.0.0.0 pod/my-pod 8080:80

      # Multiple ports
      kubectl port-forward my-pod 8080:80 8443:443
      ```

      ### Copy Files

      ```bash
      # Copy from pod to local
      kubectl cp my-pod:/path/to/file ./local-file

      # Copy from local to pod
      kubectl cp ./local-file my-pod:/path/to/file

      # Copy from specific container
      kubectl cp my-pod:/file ./file -c container-name

      # Copy directory
      kubectl cp my-pod:/app/config ./config-backup
      ```

      ## Events

      ### Viewing Events

      ```bash
      # View all events
      kubectl get events

      # Events sorted by timestamp
      kubectl get events --sort-by='.metadata.creationTimestamp'

      # Events in specific namespace
      kubectl get events -n kube-system

      # Watch events in real-time
      kubectl get events --watch

      # Events for specific resource
      kubectl get events --field-selector involvedObject.name=my-pod

      # Events for specific type
      kubectl get events --field-selector type=Warning

      # Filter by reason
      kubectl get events --field-selector reason=Failed
      ```

      ## Resource Metrics

      ### Metrics Server Commands

      ```bash
      # Node resource usage
      kubectl top nodes

      # Node usage with labels
      kubectl top nodes --show-labels

      # Pod resource usage
      kubectl top pods

      # Pods in all namespaces
      kubectl top pods -A

      # Pods in specific namespace
      kubectl top pods -n production

      # Sort by CPU
      kubectl top pods --sort-by=cpu

      # Sort by memory
      kubectl top pods --sort-by=memory

      # Container-level metrics
      kubectl top pod my-pod --containers
      ```

      ## Common Issues & Solutions

      ### CrashLoopBackOff

      ```bash
      # View previous container logs
      kubectl logs my-pod --previous

      # Describe pod (check events)
      kubectl describe pod my-pod

      # Check resource limits
      kubectl get pod my-pod -o jsonpath='{.spec.containers[*].resources}'

      # Check liveness/readiness probes
      kubectl get pod my-pod -o jsonpath='{.spec.containers[*].livenessProbe}'
      ```

      ### ImagePullBackOff

      ```bash
      # Check events
      kubectl describe pod my-pod

      # Verify image name
      kubectl get pod my-pod -o jsonpath='{.spec.containers[*].image}'

      # Check image pull secrets
      kubectl get pod my-pod -o jsonpath='{.spec.imagePullSecrets}'

      # Test image pull manually
      docker pull <image-name>
      ```

      ### Pending Pods

      ```bash
      # Check events (insufficient resources, taints, etc.)
      kubectl describe pod my-pod

      # Check node resources
      kubectl top nodes
      kubectl describe nodes

      # Check pod resource requests
      kubectl get pod my-pod -o jsonpath='{.spec.containers[*].resources.requests}'

      # Check PVC binding
      kubectl get pvc

      # Check node selectors/affinity
      kubectl get pod my-pod -o jsonpath='{.spec.nodeSelector}'
      ```

      ### Troubleshooting Network

      ```bash
      # Check service endpoints
      kubectl get endpoints my-service

      # Test DNS resolution
      kubectl run debug --image=nicolaka/netshoot -it --rm -- bash
      nslookup my-service

      # Test connectivity
      kubectl run debug --image=curlimages/curl -it --rm -- curl http://my-service

      # Check network policies
      kubectl get networkpolicies
      kubectl describe networkpolicy my-policy
      ```

      ## Advanced Debugging

      ### Debug Container (Ephemeral)

      ```bash
      # Add debug container to running pod
      kubectl debug my-pod -it --image=busybox --target=my-container

      # Create debug pod as copy
      kubectl debug my-pod -it --copy-to=my-pod-debug --container=debugger --image=busybox

      # Debug node by creating pod on node
      kubectl debug node/my-node -it --image=busybox
      ```

      ### Cluster Info

      ```bash
      # Cluster information
      kubectl cluster-info

      # Cluster info dump
      kubectl cluster-info dump

      # API versions
      kubectl api-versions

      # API resources
      kubectl api-resources

      # Component status
      kubectl get componentstatuses
      kubectl get cs
      ```

      Master debugging in the hands-on labs!
    MARKDOWN
    l.reading_time_minutes = 20
  end

  max_seq = mod9.module_items.maximum(:sequence_order) || 1

  ModuleItem.find_or_create_by!(
    course_module: mod9,
    item_type: 'CourseLesson',
    item: lesson9,
    sequence_order: max_seq + 1
  ) { |item| item.required = true }

  puts "  ✅ Created 'Monitoring & Debugging' lesson"
end

# Module 10: Security & Operations
mod10 = k8s_course.course_modules.find_by(slug: 'security-operations')
if mod10
  lesson10 = CourseLesson.find_or_create_by!(title: "RBAC & Cluster Operations") do |l|
    l.content = <<~MARKDOWN
      # RBAC & Cluster Operations

      Implement role-based access control and perform essential cluster operations.

      ## RBAC (Role-Based Access Control)

      ### Viewing RBAC Resources

      ```bash
      # List roles (namespace-scoped)
      kubectl get roles
      kubectl get roles -A

      # List cluster roles (cluster-wide)
      kubectl get clusterroles

      # List role bindings
      kubectl get rolebindings
      kubectl get rolebindings -A

      # List cluster role bindings
      kubectl get clusterrolebindings

      # Describe role
      kubectl describe role pod-reader

      # Describe cluster role
      kubectl describe clusterrole admin
      ```

      ### Creating RBAC Resources

      ```bash
      # Create role
      kubectl create role pod-reader --verb=get,list,watch --resource=pods

      # Create cluster role
      kubectl create clusterrole deployment-manager --verb=get,list,create,delete --resource=deployments

      # Create role binding
      kubectl create rolebinding read-pods --role=pod-reader --user=john

      # Create cluster role binding
      kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=admin
      ```

      ### Testing Permissions

      ```bash
      # Check if you can perform action
      kubectl auth can-i create pods
      kubectl auth can-i delete deployments

      # Check for specific user
      kubectl auth can-i create pods --as=john
      kubectl auth can-i delete deployments --as=john --namespace=production

      # List all permissions
      kubectl auth can-i --list
      kubectl auth can-i --list --as=john
      ```

      ### Service Accounts

      ```bash
      # List service accounts
      kubectl get serviceaccounts
      kubectl get sa

      # Create service account
      kubectl create serviceaccount my-app

      # Describe service account
      kubectl describe sa my-app

      # Get service account token
      kubectl create token my-app

      # Create pod using service account
      # spec:
      #   serviceAccountName: my-app
      ```

      ## Node Management

      ### Viewing Nodes

      ```bash
      # List nodes
      kubectl get nodes

      # List nodes with details
      kubectl get nodes -o wide

      # Describe node
      kubectl describe node my-node

      # Get node YAML
      kubectl get node my-node -o yaml

      # Check node conditions
      kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.conditions[?(@.type=="Ready")].status}{"\n"}{end}'
      ```

      ### Node Maintenance

      ```bash
      # Mark node unschedulable (cordon)
      kubectl cordon my-node

      # Mark node schedulable (uncordon)
      kubectl uncordon my-node

      # Drain node (evict pods before maintenance)
      kubectl drain my-node --ignore-daemonsets --delete-emptydir-data

      # Drain with grace period
      kubectl drain my-node --ignore-daemonsets --force --grace-period=30

      # Taint node
      kubectl taint nodes my-node key=value:NoSchedule

      # Remove taint
      kubectl taint nodes my-node key=value:NoSchedule-

      # Label node
      kubectl label nodes my-node disktype=ssd

      # Remove label
      kubectl label nodes my-node disktype-
      ```

      ## Cluster Operations

      ### Namespaces

      ```bash
      # List namespaces
      kubectl get namespaces
      kubectl get ns

      # Create namespace
      kubectl create namespace production

      # Delete namespace (deletes all resources)
      kubectl delete namespace production

      # Set default namespace
      kubectl config set-context --current --namespace=production

      # Get current namespace
      kubectl config view --minify --output 'jsonpath={..namespace}'
      ```

      ### Context Management

      ```bash
      # List contexts
      kubectl config get-contexts

      # Get current context
      kubectl config current-context

      # Switch context
      kubectl config use-context my-cluster

      # Create context
      kubectl config set-context dev --cluster=my-cluster --user=developer --namespace=development

      # Delete context
      kubectl config delete-context dev
      ```

      ### Resource Management

      ```bash
      # Apply multiple files
      kubectl apply -f ./configs/

      # Apply with recursive directory scan
      kubectl apply -f ./configs/ --recursive

      # Delete resources by file
      kubectl delete -f deployment.yaml

      # Delete all resources of type
      kubectl delete pods --all
      kubectl delete deployments --all -n production

      # Delete by label
      kubectl delete pods -l app=nginx

      # Dry run (test without applying)
      kubectl apply -f deployment.yaml --dry-run=client

      # Server-side dry run
      kubectl apply -f deployment.yaml --dry-run=server
      ```

      ### Backup & Recovery

      ```bash
      # Export all resources
      kubectl get all --all-namespaces -o yaml > cluster-backup.yaml

      # Backup specific namespace
      kubectl get all -n production -o yaml > production-backup.yaml

      # Backup etcd (requires etcd access)
      ETCDCTL_API=3 etcdctl snapshot save backup.db \\
        --endpoints=https://127.0.0.1:2379 \\
        --cacert=/etc/kubernetes/pki/etcd/ca.crt \\
        --cert=/etc/kubernetes/pki/etcd/server.crt \\
        --key=/etc/kubernetes/pki/etcd/server.key

      # Verify etcd backup
      ETCDCTL_API=3 etcdctl snapshot status backup.db --write-out=table

      # Restore etcd
      ETCDCTL_API=3 etcdctl snapshot restore backup.db --data-dir=/var/lib/etcd-restore
      ```

      ### Cluster Info

      ```bash
      # Cluster information
      kubectl cluster-info

      # Version information
      kubectl version

      # API server address
      kubectl cluster-info | grep 'Kubernetes control plane'

      # Get cluster-wide resources
      kubectl get all --all-namespaces

      # Check cluster health
      kubectl get componentstatuses
      kubectl get cs
      ```

      ### Security Contexts

      ```bash
      # View pod security context
      kubectl get pod my-pod -o jsonpath='{.spec.securityContext}'

      # View container security context
      kubectl get pod my-pod -o jsonpath='{.spec.containers[*].securityContext}'

      # Check if pod runs as root
      kubectl get pod my-pod -o jsonpath='{.spec.containers[*].securityContext.runAsUser}'
      ```

      ### Admission Controllers

      ```bash
      # Check enabled admission controllers (requires API server access)
      kubectl exec -n kube-system kube-apiserver-master -- kube-apiserver --help | grep enable-admission-plugins

      # View pod security admission labels
      kubectl get ns my-namespace -o jsonpath='{.metadata.labels}'

      # Add pod security standard to namespace
      kubectl label namespace production pod-security.kubernetes.io/enforce=restricted
      ```

      Practice security and operations in the labs!
    MARKDOWN
    l.reading_time_minutes = 20
  end

  max_seq = mod10.module_items.maximum(:sequence_order) || 1

  ModuleItem.find_or_create_by!(
    course_module: mod10,
    item_type: 'CourseLesson',
    item: lesson10,
    sequence_order: max_seq + 1
  ) { |item| item.required = true }

  puts "  ✅ Created 'RBAC & Cluster Operations' lesson"
end

puts "\n✅ Kubectl learning lessons created successfully!"
puts "   - 8 detailed kubectl command lessons"
puts "   - Mapped to Kubernetes Complete Guide modules 2-10"
puts ""
