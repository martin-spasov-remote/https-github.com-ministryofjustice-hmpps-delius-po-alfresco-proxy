default: build
.PHONY: build

build:
	docker run --rm \
    	--env-file=config.env \
		-v $(PWD):/home/gradle/project \
		-w /home/gradle/project \
		gradle:6.3.0-jdk8 gradle clean test cucumber

run:
	docker run --rm \
		-p 8080:8080 \
    	--env-file=config.env \
		-v $(PWD):/home/gradle/project \
		-w /home/gradle/project \
		gradle:6.3.0-jdk8 gradle clean bootRun

package:
	docker run --rm \
    	--env-file=config.env \
		-v $(PWD):/home/gradle/project \
		-w /home/gradle/project \
		gradle:6.3.0-jdk8 gradle clean test cucumber bootJar

# @Deprecated - consider using sandpit-ecs-deploy instead
build-image:
	scripts/build-sandpit-docker-image.sh

##############
# env builds #
##############

sandpit-plan:
	scripts/terraform-local-builder.sh delius-core-sandpit terraform-local-plan.sh

sandpit-apply:
	scripts/terraform-local-builder.sh delius-core-sandpit terraform-local-apply.sh

# Builds the application, docker image, uploads image to ECR and deploys to ECS
sandpit-ecs-deploy:
	scripts/local-ecs-deployer.sh