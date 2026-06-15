cm() {
    if [[ -z "$1" ]]; then
        echo "Error: You must provide a file to compile."
        echo "Usage: cm <filename>"
        return 1
    else
        if [[ ! -f "$1" ]]; then
	        echo "Error: File '$1' not found!"	
     	    return 1
        else 
            file="$1"
            ftype="${file:e:l}"
            LAST_COMPILED="${file%.*}"
            if [[ $ftype == "asm" ]]; then
                if [[ -z "$2" ]]; then
                    echo "Error: You must supply assembly architecture."
                    echo "Usage: cm <filename.asm> <architecture>"
                    return 1
                else
                    if [[ $2 == "32" ]]; then
                        nasm -f elf32 $file -o $LAST_COMPILED.o
                        ld -m elf_i386 $LAST_COMPILED.o -o $LAST_COMPILED
                    elif [[ $2 == "64" ]]; then
                        nasm -f elf64 $file -o $LAST_COMPILED.o
                        ld $LAST_COMPILED.o -o $LAST_COMPILED
                    else
                        echo "Error: '$2' is not a valid x86 architecture"
                    fi
                fi
            else
                gcc $file -o $LAST_COMPILED	
	        fi
        fi 
    fi  
}

ru() {
    if [[ -n "$LAST_COMPILED" ]]; then
        if [[ -x "$LAST_COMPILED" ]]; then
	        ./"$LAST_COMPILED"
        else
	        echo "$LAST_COMPILED not found in current path."
        fi
    else
        echo "Error: Use 'cm' first!"
    fi
}
