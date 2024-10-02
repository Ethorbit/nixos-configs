{ config, lib, pkgs, ... }:

with lib;
with pkgs;

let
    version = "1.0.7";
in
{
    options = {
        ethorbit.pkgs.python.codebase-to-text = mkOption {
            type = types.package;
            default = with python312Packages; (buildPythonPackage {
                pname = "codebase_to_text";
                version = "${version}";
                doCheck = false;
                description = ''
                For GenAI and LLM usage. This package converts codebase (folder structure with files) into a single text file or a Microsoft Word document (.docx), preserving folder structure and file contents. The tool extracts file contents from various file types, including text files, documents, and more, while retaining their formatting for easy readability.
                '';
                src = (fetchFromGitHub {
                    owner = "QaisarRajput";
                    repo = "codebase_to_text";
                    rev = "${version}";
                    hash = "sha256-IfWFvEmSEHJSuYBpO2BrY4jDGhzXPt6p4Ha4dlGh4Fo=";
                });
                propagatedBuildInputs = [
                    python-docx
                    gitpython
                ];
            });
        };
    };
}
