II SSS
============

This is a system we developed to make it (sorta) easy to pass
secure session information from one application to another. This
came out of a need we had to unify 5 separate applications, each
built with different web-frameworks, under one unified "portal".

The basic idea is that we use an HMAC message passed between the
applications which contains enough user information for the
recieving application to recognize the user and instantiate a
local session for them. Since all the applications share a
single secret, which is used in the creation of the HMAC, then
the recieving application can know the session is valid and
authentic.

Author
------

Stevan Little stevan.little@iinteractive.com

Copyright and License
---------------------

Copyright 2010-2011 Infinity Interactive, Inc.

http://www.iinteractive.com

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.