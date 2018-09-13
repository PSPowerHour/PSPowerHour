# Example showing TabControls and TabItems

$output=dialog {
    TabControl -name Top {
        TabItem Fred  {
            listbox -contents (dir c:\temp | select -first 10) -name Fred2
        }
        TabItem Barney {
            listbox -contents (dir c:\temp | select -first 10) -name Barney2
        }
        TabItem Wilma {
            listbox -contents (dir c:\temp | select -first 10) -name Wilma2
        }
        TabItem Betty {
            listbox -contents (dir c:\temp | select -first 10) -name Betty2
        }
    }
}