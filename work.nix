{ ... }:
{
  home.file.".local/scripts/work-dmenu" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      BROWSER="firefox -new-tab"

      OPTIONS="Jira\nMandagsMøte\nPullRequests"

      CHOICE=$(printf "%b" "$OPTIONS" | fsel --dmenu)

      case "$CHOICE" in
          "MandagsMøte")
              $BROWSER "https://bouvetasa.sharepoint.com/sites/NRDB/_layouts/15/Doc.aspx?sourcedoc={84eabb7d-0c81-48cb-b9eb-bc558c2fbb76}&action=edit&wd=target%28Untitled%20Section.one%7C65ad74fa-9537-4327-84fa-778157b8e60a%2F2025-10-13%20%5B%C2%A0%F0%9F%8E%AF%C2%A0Jardar%5D%7C57149527-77d6-453f-a307-57cd7ca3e321%2F%29&wdorigin=NavigationUrl"
              ;;
          "PullRequests")
              $BROWSER "https://github.com/CyDigAvd-Team-FRS/NasjonalRessursdatabase/pulls"
              ;;
          "Jira")
              query="$( echo "" | fsel --dmenu --prompt-only <&- )" 
              if [ -n "''${query}" ]; then 
                $BROWSER "https://jira.bouvet.no/projects/NRDB/issues/NRDB-''${query}"
              else
                $BROWSER "https://jira.bouvet.no/projects/NRDB/issues"
              fi
              ;;
      esac
    '';

  };
}
