cm() {
    [[ -z "$1" ]] && { echo "Error: You must provide a file to compile.\nUsage: cm <filename>"; return 1; }
    [[ ! -f "$1" ]] && { echo "Error: File '$1' not found!"; return 1; }

    file="$1"
    ftype="${file:e:l}"
    LAST_COMPILED="${file%.*}"

    case "$ftype" in
        asm)
            [[ -z "$2" ]] && { echo "Error: You must supply assembly architecture."; echo "Usage: cm <filename.asm> <architecture>"; return 1; }
            
            if [[ $2 == "32" ]]; then
                nasm -f elf32 $file -o $LAST_COMPILED.o && ld -m elf_i386 $LAST_COMPILED.o -o $LAST_COMPILED
            elif [[ $2 == "64" ]]; then
                nasm -f elf64 $file -o $LAST_COMPILED.o && ld $LAST_COMPILED.o -o $LAST_COMPILED
            else
                echo "Error: '$2' is not a valid x86 architecture"
                return 1
            fi
            rm -f "${LAST_COMPILED}.o"
            ;;
        c)
            gcc $file -Wall -o $LAST_COMPILED
            ;;
        cpp) 
            if [[ "$2" == "-O3" || "$2" == "opt" ]]; then
                g++ $file -Wall -O3 -o $LAST_COMPILED
            else
                g++ $file -Wall -o $LAST_COMPILED
            fi
            ;;
        java)
            javac $file
            ;;
        *)
            echo "Error: Unsupported file type '.$ftype'"
            return 1;
            ;;
    esac
}   

ru() {
    if [[ -z "$1" ]]; then
        if [[ -n "$LAST_COMPILED" || -n "$ftype" ]]; then
            if [[ "$ftype" == "java" ]]; then
                if [[ -f "${LAST_COMPILED}.class" ]]; then
                    if [[ "$do_clear" == "true" ]]; then
                        clear && java "$LAST_COMPILED"
                    else
                        java "$LAST_COMPILED"
                    fi
                else
                    echo "${LAST_COMPILED}.class not found in directory"
                fi
            elif [[ -x "$LAST_COMPILED" ]]; then
                if [[ $ftype == "c" || $ftype == "cpp" ]]; then
                    if [[ "$do_clear" == true ]]; then
                        clear && ./"$LAST_COMPILED"
                    else
                        ./"$LAST_COMPILED"
                    fi
                fi
            else
                echo "$LAST_COMPILED not found in current path."
                return 1
            fi
        else
            echo "Error: Use 'cm' first!"
            return 1
        fi
    else
        if [[ $1 == "clear" || $1 == "-c" ]]; then
            if [[ -n "$do_clear" && "$do_clear" == "true" ]]; then
                do_clear=false
            else
                do_clear=true
            fi
            ru
        else
            echo "$1 is not a valid parameter. "
        fi
    fi
}

cmru() {
    if cm $1 $2; then
        ru
    fi
}
