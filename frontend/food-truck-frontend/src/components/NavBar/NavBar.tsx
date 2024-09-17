import { ReactNode } from "react";

interface Props {
  children?: ReactNode;
}

function NavBar({ children }: Props) {
  return (
    <nav className="navbar navbar-expand-lg navbar-light bg-light">
      <a className="px-4 navbar-brand" href="#">
        Food Truck Searcher
      </a>

      <div className="collapse navbar-collapse" id="navbarSupportedContent">
        {children}
      </div>
    </nav>
  );
}

export default NavBar;
