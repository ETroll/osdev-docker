# OSDev Docker image

This dockerfile is created to use together with the meaty skeleton template and the bare bone templates on the osdev wiki.

* Meat skeleton: http://wiki.osdev.org/Meaty_Skeleton
* Bare bones: http://wiki.osdev.org/Bare_Bones

It contains a i686-elf cross compiler and all tools necessary to build the meaty skeleton and bare bones templates
on the osdev wiki at http://wiki.osdev.org

### Example usage
```
docker run --privileged -v <your-local-folder>:/src osdev iso.sh
```
