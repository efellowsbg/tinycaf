# What is tinycaf

tinycaf is an Infrastructure as Data framework (IaD) for Azure & GitHub.

## Vision

Despite the promises that Terraform makes - "if you want to change something on
the infra, you just change it in code, and it magically takes care of the rest",
the azurerm provider still has a lot of edge cases to be considered and properly
dealt with. It is advised to create smaller/atomic changes and have them
replicated/tested in a dev environment when dealing with critical infra.

### Where CAF failed?

CAF tried to be too generic.
This was kind of the goal in the beginning - try to unify all the custom modules
that people have built over the years to have it be consistent for everyone but
it ended up being too close to terraform, to the point of simply being a wrapper
with more restrictions than helpful integrations.

IaD must be read as type-checked specifications not as code.
IaD should be the IR of draw.io diagrams, compiled to terraform.

CAF is tightly coupled around working in a dev container, and although helpful
it shouldn't be a demand (some performance issues on Windows, bypass checks from
GH UI, slower build times, more versions to manage, etc).

CAF abstracted many important design surfaces which reduced visibility and
flexibility:
1. Regions are wrappers around locations (and confusing ones)
2. Levels are wrappers around Storage Account containers
3. Landingzones are wrappers around state files
4. Rover is a wrapper around 2 maybe 3 bash scripts
5. Level access is restricted to differential depth of 1
6. Complete lack of documentation (especially high and low-level, only examples)
7. xxxx_key gets confusing when talking about other keys. (use _ref)


---
blog shit
---

I am not familiar with 100% of the inner workings of CAF and how the 3 (giant)
repos all come together, neither am I an engineer at Microsoft attending their
internal design meetings but I know enough to make tinycaf work and to derive
what the intetions behind certain design choices were, and how they could be
improved. All of these are my personal opinions and experiences.

1. The great region swap
2. The global_settings cyclic dependency
3. Deleting a landinzone ??
4. az cli dev container leak
5. Private DNS troubles (and shitty architecture)
6. Copy Pasta (missing configs)

storage account not found (due to service endpoint not being storage.global)


