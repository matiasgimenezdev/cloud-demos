config {
    module = true
    force = false
}

# Disallow // comments in favor of #.
rule "terraform_comment_syntax" {
enabled = false
}

# Disallow variables, data sources, and locals that are declared but never used.
rule "terraform_unused_declarations" {
enabled = true
}